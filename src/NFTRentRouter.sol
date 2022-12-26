// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

// initializing the CFA Library
import {ISuperfluid, ISuperToken, ISuperApp} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import {SuperTokenV1Library} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";
import "./IReNFT.sol";
import "./IResolver.sol";

contract NFTRentRouter {
    // the logic for the ReNFT contract
    IReNft public renft;
    // the logic to integrate superTokens
    IResolver public resolver;

    ISuperToken public daix;

    constructor() {
        // Retrieve renft & resolver using ReNFT V1 address
        renft = IReNft(address(0x94D8f036a0fbC216Bb532D33bDF6564157Af0cD7));
        resolver = IResolver(
            address(0x945E589A4715d1915e6FE14f08e4887Bc4019341)
        );
    }

    function createFlowFromContract(
        ISuperToken token,
        address receiver,
        int96 flowRate
    ) external {
        token.createFlow(receiver, flowRate);
    }

    function updateFlowByOperatorTest(
        address receiver,
        ISuperToken token,
        int96 flowRate
    ) public {
        token.updateFlow(receiver, flowRate);
    }

    function deleteFlowByOperator(
        address sender,
        address receiver,
        ISuperToken token
    ) public {
        token.deleteFlow(sender, receiver);
    }
}
