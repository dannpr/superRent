// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
// initializing the CFA Library
pragma solidity 0.8.14;

import {ISuperfluid} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {IConstantFlowAgreementV1} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import {CFAv1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RFlow is ERC721Holder, ERC1155Receiver, ERC1155Holder {
    using CFAv1Library for CFAv1Library.InitData;
    using Counters for Counters.Counter;

    //initialize cfaV1 variable
    CFAv1Library.InitData public cfaLib;

    uint256 private lendingId = 1;

    struct Lending {
        uint256 id;
        address lenderAddress;
        uint8 maxRentDuration;
        bytes4 dailyRentPrice;
        bytes4 nftPrice;
        uint8 lentAmount;
        ISuperToken paymentToken;
        uint256 tokenId;
    }

    struct Renting {
        uint256 id;
        address renterAddress;
        uint8 rentDuration;
        uint32 rentedAt;
    }

    struct LendingRenting {
        Lending lending;
        Renting renting;
    }

    mapping(uint256 => LendingRenting) private lendingRenting;

    constructor(ISuperfluid host) {
        //initialize InitData struct, and set equal to cfaV1
        cfaLib = CFAv1Library.InitData(
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

    // function to create a flow with the user data through renting
    function lend(
        address _nfts,
        uint256 _tokenIds,
        uint256 _lendAmounts,
        uint8 _maxRentDurations,
        bytes4 _dailyRentPrices,
        bytes4 _nftPrices,
        ISuperToken memory _paymentTokens
    ) external {
        lendingRenting[lendingId.current()] = LendingRenting(
            Lending(
                lendingId.current(),
                msg.sender,
                _maxRentDurations,
                _dailyRentPrices,
                _nftPrices,
                _lendAmounts,
                _paymentTokens,
                _tokenIds
            )
        );

        doLending(msg.sender, lendingId);
        lendingId.increment();
    }

    // function to update a flow with the user data through renting or after renting
    // function to delete a flow with the user data after the rent is over
    // create a flow with the user data

    // actions

    function doLending(address lender, uint256 _lendingId) external {
        require(
            _lendingId == lendingRenting[_lendingId],
            "Lending ID is not valid"
        );
        // transfer the NFT to the contract
        _transfer(
            address(this),
            lender,
            lendingRenting[_lendingId].lending.tokenId
        );
        // emit an event
    }
}
