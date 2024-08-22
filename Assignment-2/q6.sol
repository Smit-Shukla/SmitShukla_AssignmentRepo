// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    // create a simple candidate struct
    struct Candidate {
        string name;
        uint256 votes;
    }

    // array of Candidate
    Candidate[] public candidates;
    //mapping voter address to bool so a voter cant vote twice
    mapping(address => bool) public Voter;

    // add Candidate for election
    function addCandidate(string memory name) public {
        candidates.push(Candidate(name, 0));
    }

    // Vote candidate
    // Check if the voter has already voted or not
    // Check if the index of the candidate is within the bound
    // Increase the vote of the voted candidate and mark the voter as true
    function voteCandidate(uint256 candidateIndex) public returns (string memory) {
        require(!Voter[msg.sender], "Already Voted!");
        require(candidateIndex < candidates.length, "Invalid index!");

        candidates[candidateIndex].votes += 1;
        Voter[msg.sender] = true;
        return "Vote counted!";
    }

    // Get Votes of a particular candidate
    function getCandidateVotes(uint256 candidateIndex) public view returns (uint256) {
        return candidates[candidateIndex].votes;
    }

    // Get All the Candidate
    function getAllCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

}