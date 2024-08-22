// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventLogging {

    // event declaration
    // indexed -> provides efficient filtering when searching for logs
    event actionPerformed(address indexed user, uint256 value, string action);

    // emits an event when called
    function performAction(uint256 vM) public {
        string memory action = "Action Performed";

        emit actionPerformed(msg.sender, vM, action);
    }
}