// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import "../src/ReNFT.sol";
import "../src/Resolver.sol";

contract ReNFTScript is Script {
    function setUp() public {}

    function run() external {
        address deployerAddress = vm.envAddress("ADDRESS");
        address beneficierAddress = vm.envAddress("BENEFICIARY_ADDRESS");

        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
