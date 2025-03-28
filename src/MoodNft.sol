// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

error MoodNft_NotAuthorisedToFlipMood();

contract MoodNft is ERC721 {
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    uint256 private s_tokenCounter;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood)  private s_tokenIdToMood;

    modifier isApprovedOrOwner(uint256 tokenId) {
        if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender){
            revert MoodNft_NotAuthorisedToFlipMood();
        }
        _;
    }

    constructor (string memory sadSvg, string memory happySvg) ERC721("MoodNFT","MN"){
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvg;
        s_happySvgImageUri = happySvg;
    }

    function mintNft() public returns(uint256) {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        return s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory){
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        }
        else {
            imageURI = s_sadSvgImageUri;
        }

        string memory tokenMetadata = Base64.encode(
            bytes (
                abi.encodePacked(
                    '{"name: "',
                    name(),
                    '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image": ',
                    imageURI,
                    '"}'
                )
            )
        );

        return string (
            abi.encodePacked(
                _baseURI(),
                tokenMetadata
            )
        );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function getMoodOfNft(uint256 tokenId) external view returns(uint256) {
        return uint256(s_tokenIdToMood[tokenId]);
    }

    function flipMood(uint256 tokenId) external isApprovedOrOwner(tokenId) {
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        }
        else{
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }
}