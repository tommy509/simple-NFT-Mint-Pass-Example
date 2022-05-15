# Simple MintPass CONTRACT

_This project is an example of mint pass nft smart contract with a nodejs backend and html  user interface. It is a simple implementation that swap Ether for erc721 tokens  with timelocks, blacklisted users,  roles and categories(silver, platinum, gold mint passes). Built with solidity this contract consumes chainlink feeds to bring offchain data like  usd/eth  current price on chain._

_The process to  have a mintpass is only to click on buy button in the user interface, a metamask transaction will popup_

_After transaction complete user will have to add the token Id to his wallet and done_

_This example has been deployed on Kovan testnet at following address 0xf484a46c14e0b44bb40275727587e14d3cc4d5b6_

### Requirements 📋

_NODE JS_

_Node package manager_


## Installation 🔧

```
npm install
```

## Compilation 📦

```
npx hardhat compile
```

Look for  **Deployment**  to know more about how to deploy this project.


## Scripts ⚙️

_Scripts can be found inside the scripts folder and can be excecuted like the command below._
_Scripts allow us to call methods or get variables from the contract using javascript_

```
node scripts/scriptName.js
```

### Run the server ⌨️

_This project come with built in API which can be serve using following command_

```
Node server.js
```

## Deployment 🚀

_To deploy compiled contracts please enter commands below_
_In that case, deployment is beeing done to ropsten testnet_

```
npx hardhat run scripts/deploy.js --network ropsten 
```

## Made with 🛠️

_Tools used to create this project_

* [NodeJS](https://nodejs.org/es/) - API Development
* [Expressjs](https://expressjs.com/es/) - API Framewwork
* [Solidity](https://docs.soliditylang.org/en/v0.8.11/) - Smart contract language
* [OpenZeppelin](https://github.com/OpenZeppelin) -  Provides security products to build, automate, and operate decentralized applications.
* [Hardhat-ethers](https://hardhat.org/) - debugging
* [DotEnv](https://www.npmjs.com/package/dotenv) - environment variables
* [Alchemy-web3](https://alchemy.com/) - Blockchain interactions



## Versions 📌

0.0.1

## Authors ✒️

_People who participated in this project development from day one_

* **Tommy Theodore** - *Initial work* - [tommy509](https://github.com/tommy509)



## Licence 📄

_SPDX-License-Identifier: MIT._
_ISC_

## Thank you for reading 🎁

* Let the world know about this project 📢
* If it was useful to you buy us a beer🍺 or a coffee☕. 
```
0x1552ef1C29D09310bebA7abEDa20Aa4717687670
```
* Thanks a lot for reading🤓.



---
⌨️ with ❤️ by [tommy509](https://github.com/tommy509) 😊
