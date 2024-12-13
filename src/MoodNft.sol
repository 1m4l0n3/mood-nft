// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721 {
    string private s_sadSvg;
    string private s_happySvg;
    uint256 private s_tokenCounter;
    constructor (string memory sadSvg, string memory happySvg) ERC721("MoodNFT","MN"){
        s_tokenCounter = 0;
        s_sadSvg = sadSvg;
        s_happySvg = happySvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }
}