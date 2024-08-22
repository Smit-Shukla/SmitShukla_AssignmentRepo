// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract q1 {

    string str = "Hello World!";

    // view "Hello World" when function called
    function helloWorld() public view returns (string memory) {
        return str;
    }
}
