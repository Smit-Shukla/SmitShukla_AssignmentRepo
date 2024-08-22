// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GreetingMessage {
    mapping (address => string) public greetingMessage;

    // set greeting message by user
    function setGreetingMessage(string memory sM) public {
        greetingMessage[msg.sender] = sM;
    }

    // retrieve/show greeting message
    function getGreetingMessage() public view returns (string memory) {
        return greetingMessage[msg.sender];
    }
}