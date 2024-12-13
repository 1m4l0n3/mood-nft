// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftDeploy is Script {
    string private s_happySvgURI;
    string private s_sadSvgURI;
    constructor(string memory happySvgURI, string memory sadSvgURI) {
        s_happySvgURI = happySvgURI;
        s_sadSvgURI = sadSvgURI;
    }
    function run() external returns(MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft =  new MoodNft(s_happySvgURI,s_sadSvgURI);
        vm.stopBroadcast();
        return moodNft;
    }
}


