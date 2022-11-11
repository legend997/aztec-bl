import { BlockSource, Block } from './index.js';
import { EventEmitter } from 'events';
import { fetch } from '../iso_fetch/index.js';
import { Deserializer } from '../serialize/index.js';
// import { createDebugLogger } from '@aztec/barretenberg/log';
// const debug = createDebugLogger('bb:server_block_source');

export class ServerBlockSource extends EventEmitter implements BlockSource {
  private running = false;
  private runningPromise = Promise.resolve();
  private interruptPromise = Promise.resolve();
  private interruptResolve = () => {};
  protected baseUrl: string;

  constructor(baseUrl: URL, private pollInterval = 10000, protected version = '') {
    super();
    this.baseUrl = baseUrl.toString().replace(/\/$/, '');
  }

  public async getLatestRollupId() {
    const url = new URL(`${this.baseUrl}/get-blocks`);
    const init = this.version ? ({ headers: { version: this.version } } as RequestInit) : {};
    const response = await this.awaitSucceed(() => fetch(url.toString(), init));
    const result = Buffer.from(await response.arrayBuffer());
    const des = new Deserializer(result);
    return des.int32();
  }

  public async start(from = 0) {
    this.running = true;
    this.interruptPromise = new Promise(resolve => (this.interruptResolve = resolve));

    const emitBlocks = async () => {
      try {
        const blocks = await this.getBlocks(from);
        for (const block of blocks) {
          this.emit('block', block);
          from = block.rollupId + 1;
        }
      } catch (err) {
        // debug(err);
      }
    };

    await emitBlocks();

    const poll = async () => {
      while (this.running) {
        await emitBlocks();
        await this.sleepOrInterrupted(this.pollInterval);
      }
    };
    this.runningPromise = poll();
  }

  public stop() {
    this.running = false;
    this.interruptResolve();
    return this.runningPromise;
  }

  private async awaitSucceed(fn: () => Promise<Response>) {
    while (true) {
      try {
        const response = await fn();
        if (response.status == 409) {
          const body = await response.json();
          this.emit('versionMismatch', body.error);
          throw new Error(body.error);
        }
        if (response.status !== 200) {
          throw new Error(`Bad status code: ${response.status}`);
        }
        return response;
      } catch (err: any) {
        console.log(err.message);
        await new Promise(resolve => setTimeout(resolve, 10000));
      }
    }
  }

  public async getBlocks(from?: number) {
    const url = new URL(`${this.baseUrl}/get-blocks`);
    if (from !== undefined) {
      url.searchParams.append('from', from.toString());
    }
    const init = this.version ? ({ headers: { version: this.version } } as RequestInit) : {};
    const response = await this.awaitSucceed(() => fetch(url.toString(), init));
    const result = Buffer.from(await response.arrayBuffer());
    const des = new Deserializer(result);
    des.int32();
    return des.deserializeArray(Block.deserialize);
  }

  private async sleepOrInterrupted(ms: number) {
    let timeout!: NodeJS.Timeout;
    const promise = new Promise(resolve => (timeout = setTimeout(resolve, ms)));
    await Promise.race([promise, this.interruptPromise]);
    clearTimeout(timeout);
  }
}