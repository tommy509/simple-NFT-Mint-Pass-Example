// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SimpleMintPass  is ERC721URIStorage{
    using SafeCast for int256;
    using SafeMath for uint256;
    AggregatorV3Interface internal priceFeed;
    uint256 public projectLimit = 100;
    uint256 public tokenCount;
    address public contractOwner;
       struct Pass {
        uint256 id;
        string uri;
        int price;
    }

    mapping(uint256 => Pass) public categoryDetails;
    mapping(uint256 => uint256) public projectMints;
    mapping(uint256 => uint256) public category;
    mapping(address => bool) public userAddr;
    mapping(address => uint) public blacklist;
 

     constructor() ERC721("Simple", "SMP") {
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
                contractOwner = msg.sender;
        categoryDetails[1] = Pass({
            id: 1,
            uri: "https://gateway.pinata.cloud/ipfs/QmbjfNbUh87XjTH2pbt8EaREwWgXC5c1psAcSihrS3YyhZ",
            price: 5
        });
        categoryDetails[2] = Pass({
            id: 2,
            uri: "https://gateway.pinata.cloud/ipfs/QmaeMBVgRV67h1oL6mm2p7cNx658m3mDhz3pUbMoibxLZ1",
            price: 10
        });
        categoryDetails[3] = Pass({
            id: 3,
            uri: "https://gateway.pinata.cloud/ipfs/QmU5XdwLkiAz3hGWBc5PLhXHjhs3hqPhLfjvajuLRJ9RP6",
            price: 20
        });
    }

    
    modifier onlyOwner() {
        require(msg.sender == contractOwner, "not contract owner");
        _;
    }

    modifier notBlackListed() {
       require(block.timestamp > blacklist[msg.sender], "blacklisted user");
        _;
    }



    function getETHLatestPrice() public view returns (int) {
        (
            ,
            int price,
            ,
            ,
        ) = priceFeed.latestRoundData();
        return price;
    }


   function getTokenPrice(uint tokenId) public view returns (uint256) {
    uint256 tokenUSDPrice = uint256(categoryDetails[tokenId].price*10**20);
    uint256 etherUSDPrice = uint256(getETHLatestPrice()*10**8*10**18);
    uint256 tokenPrice = (tokenUSDPrice*10**18)/etherUSDPrice * 1 ether;
    return tokenPrice/10000;
    }
    
    function setUri(string memory tokenURI, uint256 tokenId)
        external
        onlyOwner
    {
        _setTokenURI(tokenId, tokenURI);
    }


    function setCategoryUri(string memory tokenURI, uint256 categoryId)
        public
        onlyOwner
    {
        categoryDetails[categoryId].uri = tokenURI;
    }

    function transferOwnership(address owner) public onlyOwner {
        contractOwner = owner;
    }

    function setPrice(int silverPrice, int goldPrice, int platinumPrice) external onlyOwner{
        categoryDetails[1].price = silverPrice;
        categoryDetails[2].price = goldPrice;
        categoryDetails[3].price = platinumPrice;
    }

    function updateMintingLimit(uint256 limit) external onlyOwner{
        projectLimit = limit;
    }



    function isOwner(address user) public view returns (bool)  {
        if (user == contractOwner) {
            return true;
        } else {
            return false;
        }
    }

    function burn(uint256 tokenId) public onlyOwner{
       _burn(tokenId);
    }

    function blockUser(address user) public onlyOwner{
       blacklist[user] = block.timestamp + 1 weeks;
    }

  

    function airdrop(
        address[] memory _to,
        uint256[] memory _value,
        uint256 categoryId
    ) public onlyOwner{
        require(_to.length == _value.length);
        for (uint256 i = 0; i < _to.length; i++) {
            for (uint256 j = 0; j < _value[i]; j++) {
            uint256 currentMint = projectMints[categoryId];
            require(block.timestamp > blacklist[_to[i]], "blacklisted user");
            require(categoryId > 0,"wrong category");
            require(categoryId < 4,"wrong category");
            require(currentMint < projectLimit, "No more mint passes to send");
            currentMint++;
            tokenCount++;
            userAddr[_to[i]] = true;
            _mint(_to[i], tokenCount);
            _setTokenURI(tokenCount, categoryDetails[categoryId].uri);
            projectMints[categoryId] = currentMint;
            category[tokenCount] = categoryId;
            }
        }
    }

    function withdraw(uint256 amount) public {
        payable(contractOwner).transfer(amount);
    }

    receive() external payable {
        uint256 tokenId;
        require(
            msg.value == getTokenPrice(1) ||
                msg.value == getTokenPrice(2)  ||
                msg.value == getTokenPrice(3), "wrong amount sent"
        );
        if (msg.value == getTokenPrice(1) ) {
            tokenId = 1;
            uint256 currentMint = projectMints[tokenId];
            require(currentMint < projectLimit, "No more passes available");
            require(block.timestamp > blacklist[msg.sender], "blacklisted user");
            currentMint++;
            tokenCount++;
            userAddr[msg.sender] = true;
            _mint(msg.sender, tokenCount);
            _setTokenURI(tokenCount, categoryDetails[tokenId].uri);
            projectMints[tokenId] = currentMint;
            category[tokenCount] = 1;
        } else if (msg.value == getTokenPrice(2)) {
            tokenId = 2;
            uint256 currentMint = projectMints[tokenId];
            require(currentMint < projectLimit, "No more passes available");
            require(block.timestamp > blacklist[msg.sender], "blacklisted user");
            tokenCount++;
            userAddr[msg.sender] = true;
            currentMint++;
            _mint(msg.sender, tokenCount);
            _setTokenURI(tokenCount, categoryDetails[tokenId].uri);
            projectMints[tokenId] = currentMint;
            category[tokenCount] = 2;
        } else if (msg.value == getTokenPrice(3)) {
            tokenId = 3;
            uint256 currentMint = projectMints[tokenId];
            require(currentMint < projectLimit, "No more passes available");
            require(block.timestamp > blacklist[msg.sender], "blacklisted user");
            tokenCount++;
            userAddr[msg.sender] = true;
            currentMint++;
            _mint(msg.sender, tokenCount);
            _setTokenURI(tokenCount, categoryDetails[tokenId].uri);
            projectMints[tokenId] = currentMint;
            category[tokenCount] = 3;
        }
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 passId
    ) public virtual override notBlackListed {
            if (userAddr[sender] == true) {
                userAddr[recipient] = true;
                super.transferFrom(sender, recipient, passId);
                if (ERC721(address(this)).balanceOf(sender) <= 0) {
                    userAddr[sender] = false;
                }
            } else {
                super.transferFrom(sender, recipient, passId);
            }
    }
}

