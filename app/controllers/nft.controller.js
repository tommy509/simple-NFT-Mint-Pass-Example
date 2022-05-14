require("dotenv").config()
const API_URL = process.env.API_URL
const { createAlchemyWeb3 } = require("@alch/alchemy-web3")
const web3 = createAlchemyWeb3(API_URL)
const contract = require("../../artifacts/contracts/SimpleMintPass.sol/SimpleMintPass.json")
const contractAddress = process.env.MASTER
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

exports.getPasses =   async function (req,res) {
    var data = {};
        data.contractAddress = contractAddress;
       await nftContract.methods.projectMints(1).call((error, result) => {
        data.silverMints = result;
        });

        await nftContract.methods.projectMints(2).call((error, result) => {
        data.goldMints = result;
        });

        await nftContract.methods.projectMints(3).call((error, result) => {
        data.platinumMints = result;
         });

        await nftContract.methods.projectLimit().call((error, result) => {
            data.limit = result;
        });

    await nftContract.methods.getTokenPrice(1).call((error, result) => {
    data.silverPrice = result;
    });

    await nftContract.methods.categoryDetails(1).call((error, result) => {
        data.silverUSDPrice = result.price;
        });
    await nftContract.methods.getTokenPrice(2).call((error, result) => {
    data.goldPrice = result;
    });
    await nftContract.methods.categoryDetails(2).call((error, result) => {
        data.goldUSDPrice = result.price;
        });
    await nftContract.methods.getTokenPrice(3).call((error, result) => {
     data.platinumPrice = result;
    });
    await nftContract.methods.categoryDetails(3).call((error, result) => {
        data.platinumUSDPrice = result.price;
        });
    data.silverTraded = data.silverPrice*data.silverMints;
    data.goldTraded = data.goldPrice*data.goldMints;
    data.platinumTraded = data.platinumPrice*data.platinumMints;
    res.json({data});
 } 

exports.getSilverPrice =   async function (req,res) {
   nftContract.methods.getTokenPrice(1).call((error, result) => {
    res.json({price:result})
    });
} 

exports.getGoldPrice =   async function () {
    nftContract.methods.getTokenPrice(2).call((error, result) => {
       return result;
     });
 } 

 exports.getPlatinumPrice =   async function () {
    nftContract.methods.getTokenPrice(3).call((error, result) => {
       return result;
     });
 } 