// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    mapping (address => string) name;

    // get name of the user
    function getName() public view returns (string memory){
        return name[msg.sender];
    }

    // retrieve or show the name of user
    function setName(string memory nM) public {
        name[msg.sender] = nM;
    }
}