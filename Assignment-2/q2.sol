// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerValue {
    int256 private value;

    //set integer value
    function setValue(int256 sM) public {
        value = sM;
    }

    // view integer value
    function getValue() public view returns (int256) {
        return value;
    }
}