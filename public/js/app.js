App = {
    buyPass: async (price,contractAddress) => {
        if (typeof web3 !== 'undefined') {
            web3Provider = web3.currentProvider
            web3 = new Web3(web3.currentProvider)
        } else {

        }
        if (window.ethereum) {
            window.web3 = new Web3(ethereum)
            try {
                await ethereum.enable();
                var address =   (await web3.eth.getAccounts())[0];
                  $.get("/data/SimpleMintPass.json", function(contract, status){ 
                  const nftContract = new web3.eth.Contract(contract.abi, contractAddress);
                 
                web3.eth.sendTransaction({
                    from: address,
                    to: contractAddress,
                    value:  web3.utils.toWei(String(price), 'ether'),
                    gasLimit: 350000
                })
                    .on('transactionHash', function (hash) {
                        //do something
                    });
                  });            
            } catch (error) {
                   // do something
            }
        } else {
           // do something
        }
    }
}




