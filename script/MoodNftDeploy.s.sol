// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNftDeploy is Script {
    string private s_happySvgURI;
    string private s_sadSvgURI;

    constructor(string memory happySvgPath, string memory sadSvgPath) {
        s_happySvgURI = svgToImageURI(vm.readFile(happySvgPath));
        s_sadSvgURI = svgToImageURI(vm.readFile(sadSvgPath));
    }

    function run() external returns(MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft =  new MoodNft(s_happySvgURI,s_sadSvgURI);
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(string memory svg) private pure returns(string memory){
        string memory baseURI = "data:image/svg+xml;base64";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));

        return string(abi.encodePacked(baseURI,svgBase64Encoded));
    }
}


