// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

contract DynamicSvgNft is ERC721{
    // Mint an NFT based off the price of ETH
    // If ETH > someNumber : smile
    // Otherwise : Frown
    uint256 public s_tokenCounter;
    constructor(string memory highSvg, string memory lowSvg) 
    ERC721("Dynamic SVG NFT", "DSN"){
        s_tokenCounter = 0;
    }

    function svgToImageURI(string memory svg) public pure returns(string memory){
        string memory baseImageURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

    }

    function mintNft() external {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter += 1;
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
        {
            string memory metaDataTemplate = '{ "name" : "Dynamic SVG", "description" : "A cool NFT", "attributes" : [{ "trait_type" : "coolness",  "value": 100  } ], "image" : "?????" }';
            bytes memory metaDataTemplateInBytes = bytes(metaDataTemplate);
            string memory encodedMetadata = Base64.encode(metaDataTemplateInBytes);
            return (string(abi.encodePacked(_baseURI(), encodedMetadata)));

        }




}