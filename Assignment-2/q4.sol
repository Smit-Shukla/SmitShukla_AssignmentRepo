// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrackCount {
    uint256 private counts = 0;

    // increment the counts variable
    function increment() public {
        counts++;
    }

    // retrieve/view the counts
    function getCounts() public view returns (uint256) {
        return counts;
    }
}