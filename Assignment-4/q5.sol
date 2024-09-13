// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract DonationContract {
    mapping (address => uint256) public donations;
    address[] public recipients;

    event DonationMade(address donor, address recipients, uint256 amount);


    function makeDonation(address _recipient) public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        donations[_recipient] += msg.value;
        emit DonationMade(msg.sender, _recipient, msg.value);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawFunds() public {
        uint256 amount = donations[msg.sender];
        require(amount > 0, "No funds available for withdrawal");

        donations[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }

}