// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.6;

import "forge-std/Script.sol";
import "../src/ReNFT.sol";
import "../src/Resolver.sol";

contract ReNFTScript is Script {
    function setUp() public {}

    function run() external {
        address deployerAddress = vm.envAddress("ADDRESS");
        address beneficierAddress = vm.envAddress("BENEFICIARY_ADDRESS");
        address resolverAddress;
        address USDxAddress = address(
            0xb7Bd4fE6406ff79ABB3512033fFF0d55Eb5eaeB1
        );

        vm.startBroadcast();

        // Deploy Resolver
        Resolver resolver = new Resolver(deployerAddress);
        resolverAddress = address(resolver);

        // Deploy ReNFT
        ReNFT renft = new ReNFT(
            resolverAddress,
            payable(beneficierAddress),
            deployerAddress
        );

        // Set payment tokens
        resolver.setPaymentToken(1, USDxAddress);

        vm.stopBroadcast();
    }
}
