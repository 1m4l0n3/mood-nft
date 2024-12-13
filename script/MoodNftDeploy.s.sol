// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftDeploy is Script {
    function run() external returns(MoodNft) {
        string memory happySvgURI = vm.envString("happySvgURI") ;
        string memory sadSvgURI = vm.envString("sadSvgURI") ;
        vm.startBroadcast();
        MoodNft moodNft =  new MoodNft(happySvgURI,sadSvgURI);
        vm.stopBroadcast();
        return moodNft;
    }
}


