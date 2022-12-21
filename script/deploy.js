// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const { parseJson, toWei } = require("ethereumjs-util"); // bad practice to use ethereumjs-util in production
const { use, deploy } = require("hardhat/transaction"); // bad practice to use hardhat/transaction in production
const { ethers } = require("hardhat");

async function main() {

  const contractJson = parseJson("deployments/goerli/ERC721.json");
  const contract = await deploy(contractJson, "ERC721", "NFT", "NFT");
  console.log(`ERC721 deployed to ${contract.address}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
