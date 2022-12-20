require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    hardhat: {
      chainId: 1,
      forking: {
        url: process.env.ALCHEMY_MAINNET_URL,
        blockNumber: 13308800
      },
    }
  },
  goerli: {
    url: process.env.ALCHEMY_GOERLI_URL,
    accounts: [process.env.PRIVATE_KEY],
  }, 
  solidity: "0.8.17",
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};
