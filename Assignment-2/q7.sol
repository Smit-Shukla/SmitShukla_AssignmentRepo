// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner {
    address public owner;

    // set owner to the account deploying contract
    constructor() {
        owner = msg.sender;
    }

    // modifier makes such that only the owner can call the function
    modifier ownerName() {
        require(msg.sender == owner, "Only contract owner can call this function!");
        _;
    }
}