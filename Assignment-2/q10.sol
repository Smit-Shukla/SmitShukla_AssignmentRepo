// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageStorage {
    // Map address to string
    mapping (address => string) public messages;

    // store user message
    function storeMessage(string memory message) public {
        messages[msg.sender] = message;
    }

    // retrieve user message
    function getMessage() public view returns (string memory) {
        return messages[msg.sender];
    }
}