// Verification Key Hash: 9c26fe46dc1cf4223259399a3a6c081c4458e7451aea5c97c3fb5691c5c345fd
// SPDX-License-Identifier: GPL-2.0-only
// Copyright 2020 Spilsbury Holdings Ltd

pragma solidity >=0.6.0 <0.8.0;
pragma experimental ABIEncoderV2;

import {StandardTypes} from '../cryptography/StandardTypes.sol';
import {Bn254Crypto} from '../cryptography/StandardBn254Crypto.sol';

library Rollup1x4VkStandard {
    using Bn254Crypto for StandardTypes.G1Point;
    using Bn254Crypto for StandardTypes.G2Point;

    function get_verification_key() internal pure returns (StandardTypes.VerificationKey memory) {
        StandardTypes.VerificationKey memory vk;

        assembly {
            mstore(add(vk, 0x00), 8388608) // vk.circuit_size
            mstore(add(vk, 0x20), 17) // vk.num_inputs
            mstore(add(vk, 0x40),0x0210fe635ab4c74d6b7bcf70bc23a1395680c64022dd991fb54d4506ab80c59d) // vk.work_root
            mstore(add(vk, 0x60),0x30644e121894ba67550ff245e0f5eb5a25832df811e8df9dd100d30c2c14d821) // vk.domain_inverse
            mstore(add(vk, 0x80),0x2165a1a5bda6792b1dd75c9f4e2b8e61126a786ba1a6eadf811b03e7d69ca83b) // vk.work_root_inverse
            mstore(mload(add(vk, 0xa0)), 0x249ec7e900a27b6a4b22f1d2a7e1ecf0dcc4f11f8608b6e0f62398639c5e962d)//vk.Q1
            mstore(add(mload(add(vk, 0xa0)), 0x20), 0x24b5387b16ffd80b8865dea841bc09cc0a7538a2c102ba9eaa4682e4a42b6d79)
            mstore(mload(add(vk, 0xc0)), 0x2c755f25165f7aa44484628b2ed8eecfc7a132a23a6f4e12eafa8fbe327f20a1)//vk.Q2
            mstore(add(mload(add(vk, 0xc0)), 0x20), 0x2dd8d36de721d653b235644a8446c6fa5659c78a3894cf0a514ffe7392e7ecb2)
            mstore(mload(add(vk, 0xe0)), 0x13d757f78a178a6905871c726b498098ad4145175d8dedb55639531d0d0e7409)//vk.Q3
            mstore(add(mload(add(vk, 0xe0)), 0x20), 0x142ed4c9e128b5a8389915301d092ba817db35e774f9010ea593cf5d4c380a5b)
            mstore(mload(add(vk, 0x100)), 0x2b47699ad4d7d2ab043428475766e7773c04f882e44f009e23077251d1dc53de)//vk.QM
            mstore(add(mload(add(vk, 0x100)), 0x20), 0x2010fe02a44dff09693277ca71a352c9ea5a1dcdd0063810e9b0fe837062f6b6)
            mstore(mload(add(vk, 0x120)), 0x16428990ee26096835f73ccb9953eac49da2113699c058a4a1c23ae496d6f161)//vk.QC
            mstore(add(mload(add(vk, 0x120)), 0x20), 0x0be8586ee0311ed25bd061415cc2af3a0284cd499ff03cb0b91eec8fe66081f8)
            mstore(mload(add(vk, 0x140)), 0x2cb97391da782e657d504279643434025b9482f603a87611e80c9eb04f71c1af)//vk.SIGMA1
            mstore(add(mload(add(vk, 0x140)), 0x20), 0x085f9ba292e0f91463eaf514e0a8abd7b1165efb323622406f61f5dd5124eff6)
            mstore(mload(add(vk, 0x160)), 0x04475840dc5379142c93320cbe4417d485890295b6f27f1b49fd214ef412a7a4)//vk.SIGMA2
            mstore(add(mload(add(vk, 0x160)), 0x20), 0x2a2933d362f35852fd58e405c0f8b3a170963f9f8349655e8e8637fa729a099c)
            mstore(mload(add(vk, 0x180)), 0x140ba9ecc6f1f4a8f4610e88eb8267f674d07de02af51118b9ccc94c2ea84f24)//vk.SIGMA3
            mstore(add(mload(add(vk, 0x180)), 0x20), 0x1a61e5ccf3b23ea3cdebc2a710f01865ac71099cddee5e7a0a61ba9b3cfa512d)
            mstore(add(vk, 0x1a0), 0x01) // vk.contains_recursive_proof
            mstore(add(vk, 0x1c0), 1) // vk.recursive_proof_public_input_indices
            mstore(mload(add(vk, 0x1e0)), 0x260e01b251f6f1c7e7ff4e580791dee8ea51d87a358e038b4efe30fac09383c1) // vk.g2_x.X.c1
            mstore(add(mload(add(vk, 0x1e0)), 0x20), 0x0118c4d5b837bcc2bc89b5b398b5974e9f5944073b32078b7e231fec938883b0) // vk.g2_x.X.c0
            mstore(add(mload(add(vk, 0x1e0)), 0x40), 0x04fc6369f7110fe3d25156c1bb9a72859cf2a04641f99ba4ee413c80da6a5fe4) // vk.g2_x.Y.c1
            mstore(add(mload(add(vk, 0x1e0)), 0x60), 0x22febda3c0c0632a56475b4214e5615e11e6dd3f96e6cea2854a87d4dacc5e55) // vk.g2_x.Y.c0
        }
        return vk;
    }
}