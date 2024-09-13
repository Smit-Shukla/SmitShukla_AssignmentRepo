// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    
    struct Proposal {
        address proposer;
        string description;
        uint256 voteCount;
    }

    // maps proposalId to Proposal
    mapping (uint256 => Proposal) public proposals;

    // maps address to proposalId and if bool is true voter has already voted for that proposal
    // its like one - many relationship (one address can vote for multiple proposals)
    mapping (address => mapping(uint256 => bool)) public voters;

    // keeps track of number of proposals
    uint256 public proposalCount;

    // events for Proposal Creation and Vote Casted
    event ProposalCreated(uint256 proposalId, string description, address proposer);
    event VoteCast(uint256 proposalId, address votedBy);

    // adds Proposal to proposals and emit Creation event
    function addProposal(string memory _description) public {
        proposals[proposalCount++] = Proposal({
            proposer: msg.sender,
            description: _description,
            voteCount: 0
        });

        emit ProposalCreated(proposalCount - 1, _description, msg.sender);
    }

    function castVotes(uint256 _proposalId) public {
        // check if proposalId is valid
        require(_proposalId < proposalCount, "Invalid Proposal ID.");
        // check if voter has already voted
        require(!voters[msg.sender][_proposalId], "Already voted for this proposal Id");

        voters[msg.sender][_proposalId]= true;
        proposals[_proposalId].voteCount++;

        emit VoteCast(_proposalId, msg.sender);
    }

    // loops through each proposal and returns the proposal with highest votes
    function winningProposal() public view returns (Proposal memory) {
        Proposal storage proposal = proposals[0];
        for(uint256 i = 0; i < proposalCount; i++) {
            if(proposals[i].voteCount > proposal.voteCount) {
                proposal = proposals[i];
            }
        }
        return proposal;
    }

    // To view a specific proposal details
    function getProposalVote(uint256 _proposalId) public view returns (uint256) {
        require(_proposalId < proposalCount, "Invalid Proposal ID.");
        return proposals[_proposalId].voteCount;
    }
    
}