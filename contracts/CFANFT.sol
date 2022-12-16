// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
// initializing the CFA Library
import {ISuperfluid} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {IConstantFlowAgreementV1} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {ISuperfluidToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol";
import {CFAv1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";

import "./interfaces/IReNFT.sol";
import "./interfaces/IResolver.sol";

contract CFANFT {
    using CFAv1Library for CFAv1Library.InitData;

    // the logic for the ReNFT contract
    IReNft public renft;
    // the logic to integrate superTokens
    IResolver public resolver;

    //initialize cfaV1 variable
    CFAv1Library.InitData public cfaV1;

    constructor(ISuperfluid host) {
        // Retrieve renft & resolver using ReNFT V1 address

        renft = IReNft(address(0x94D8f036a0fbC216Bb532D33bDF6564157Af0cD7));
        resolver = IResolver(
            address(0x945E589A4715d1915e6FE14f08e4887Bc4019341)
        );
        //initialize InitData struct, and set equal to cfaV1
        cfaV1 = CFAv1Library.InitData(
            host,
            //here, we are deriving the address of the CFA using the host contract
            IConstantFlowAgreementV1(
                address(
                    host.getAgreementClass(
                        keccak256(
                            "org.superfluid-finance.agreements.ConstantFlowAgreement.v1"
                        )
                    )
                )
            )
        );
    }

    function createFlowByOperatorTest(
        address sender,
        address receiver,
        ISuperfluidToken token,
        int96 flowRate
    ) public {
        cfaV1.createFlowByOperator(sender, receiver, token, flowRate);
    }

    function updateFlowByOperatorTest(
        address sender,
        address receiver,
        ISuperfluidToken token,
        int96 flowRate
    ) public {
        cfaV1.updateFlowByOperator(sender, receiver, token, flowRate);
    }

    function deleteFlowByOperator(
        address sender,
        address receiver,
        ISuperfluidToken token
    ) public {
        cfaV1.deleteFlowByOperator(sender, receiver, token);
    }
}
