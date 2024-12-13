// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {MoodNftDeploy} from "../script/MoodNftDeploy.s.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftTest is Test {
    string private happySvgPath;
    string private sadSvgPath;
    MoodNftDeploy private deployer;
    MoodNft private moodNft;
    address private alice;

    function setUp() public {
        happySvgPath = "./img/happy.svg";
        sadSvgPath = "./img/sad.svg";
        deployer = new MoodNftDeploy(happySvgPath,sadSvgPath);
        moodNft =  deployer.run();

        alice = makeAddr("Alice");
    }

    function testNFTName() external view {
        string memory expectedValue = "MoodNFT";
        string memory actualValue = moodNft.name();

        assert(keccak256(abi.encodePacked(expectedValue)) == keccak256(abi.encodePacked(actualValue)));
    }

    function testViewTokenURI() external {
        vm.prank(alice);
        moodNft.mintNft();
    }

    function testFlipMood() external {
        vm.prank(alice);
        uint256 tokenId = moodNft.mintNft();
        uint256 moodBeforeFlip = moodNft.getMoodOfNft(tokenId);

        vm.prank(alice);
        moodNft.flipMood(tokenId);
        uint256 moodAfterFlip = moodNft.getMoodOfNft(tokenId);
        assert(moodBeforeFlip != moodAfterFlip);
    }
}