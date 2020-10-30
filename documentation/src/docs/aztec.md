Aztec is an open source layer 2 network bringing scalability and privacy too Ethereum. Aztec uses zkSNARK proofs to provide privacy and scaling via our zkRollup service. To read more about our zkRollup and the underlying PLONK technology please see the links below.

- <a href="https://medium.com/aztec-protocol/aztec-zkrollup-layer-2-privacy-1978e90ee3b6" target="_blank">ZkRollup Introduction</a>

- <a href="https://aztec.network/research" target="_blank">AZTEC Content Library</a>

## Test Network

Our rollup is deployed on the Goerli testnet with an un-audited use at your own risk main-net version available shortly. On test networks we submit rollups every 1 minute, our main-net transaction schedule will be dependant on volume, with a 1 hour long-stop.

This code is made available free to developers via our SDK.

## Decentralisation

The rollup contract deployed to Ethereum accepts rollup proofs from the Aztec rollup provider. Should the rollup provider become unavailable, or start to behave maliciously, the system has an emergency mode. The escape hatch allows users to execute transactions directly on mainnet.

Longer term, the provisioning of rollup services will be an open market ensuring redundancy and decentralisation.