// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";

import "../src/NFTRentRouter.sol";

import {ISuperfluid, ISuperToken, ISuperApp} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {IConstantFlowAgreementV1} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {ERC1820RegistryCompiled} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/libs/ERC1820RegistryCompiled.sol";

import {TestToken} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/utils/TestToken.sol";
import {SuperfluidFrameworkDeployer, TestGovernance, Superfluid, ConstantFlowAgreementV1, InstantDistributionAgreementV1, IDAv1Library, SuperTokenFactory} from "../lib/ethereum-contracts/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.sol";

contract CFANFTTest is Test {
    CFANFT private cfa_nft;

    //superfluid protocol host
    ISuperfluid public host;
    //superfluid protocol cfa
    IConstantFlowAgreementV1 public cfa;

    //CFA library which will be used to create, update, delete stremas
    using CFAv1Library for CFAv1Library.InitData;
    CFAv1Library.InitData public cfaV1;

    //Superfluid Framework contracts
    struct Framework {
        TestGovernance governance;
        Superfluid host;
        ConstantFlowAgreementV1 cfa;
        CFAv1Library.InitData cfaLib;
        InstantDistributionAgreementV1 ida;
        IDAv1Library.InitData idaLib;
        SuperTokenFactory superTokenFactory;
    }

    SuperfluidFrameworkDeployer.Framework sf;

    function setUp() public {
        //deploying the framework
        SuperfluidFrameworkDeployer sfd = new SuperfluidFrameworkDeployer();

        //calling get framework to get contracts & initialize sf variable
        sf = sfd.getFramework();

        host = sf.host;
        cfa = sf.cfa;
        cfaV1 = CFAv1Library.InitData(host, cfa);

        // deploy contract
        cfa_nft = new CFANFT(host);
    }
}
