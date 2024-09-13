// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public owner;
    address[] public players;

    // events for entering and picking winner
    event PlayerEntered(address player);
    event WinnerSelected(address winner, uint256 amount);

    // set owner
    constructor() {
        owner = msg.sender;
    }

    // only owner can call this
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    // add player
    function enter() public payable {
        require(msg.value > 0.01 ether, "Minimum entry amount is 0.01 Ether.");
        
        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    // view players
    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    // only owner can pick winner
    function pickWinner() public onlyOwner {
        require(players.length > 0, "No players have entered the lottery.");
        
        // get a random number and modulus it with number of players so we can get a valid index
        uint256 randomIndex = random() % players.length;
        
        address winner = players[randomIndex];
        
        uint256 contractBalance = address(this).balance;
        payable(winner).transfer(contractBalance);
        
        emit WinnerSelected(winner, contractBalance);
    }

    // random function
    function random() internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));
    }

    // view balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
