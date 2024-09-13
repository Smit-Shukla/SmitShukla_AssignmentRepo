// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {

    // Create Campaign struct with necessary details
    struct Campaign {
        address creator;
        uint256 deadline;
        uint256 targetAmount;
        uint256 totalContributions;
        mapping (address => uint256) contributors;
        uint256 contributorCount;
        bool finalized;
    }

    // add events related to campaign
    event campaignCreated(uint256 campaignId, address creator, uint256 deadline, uint256 targetAmount);
    event contributionMade(uint256 campaignId, address contributor, uint256 amount);
    event campaignFinalized(uint256 campaignId, bool success);

    // map index to campaign
    mapping (uint256 => Campaign) public campaigns;
    uint256 public campaignCount;

    // create campaign and emit campaignCreated event
    function createCampaign(uint256 _deadline, uint256 _targetAmount) public {
        uint256 _campaignId = campaignCount++;

        Campaign storage campaign = campaigns[_campaignId];
        campaign.creator = msg.sender;
        campaign.deadline = block.timestamp + _deadline;
        campaign.targetAmount = _targetAmount;
        campaign.totalContributions = 0;
        campaign.contributorCount = 0;
        campaign.finalized = false;

        emit campaignCreated(_campaignId, campaign.creator, campaign.deadline, campaign.targetAmount);
    }

    function contribute(uint256 _campaignId) public payable {
        Campaign storage campaign = campaigns[_campaignId];
        // Check if campaign is over or not
        require(block.timestamp < campaign.deadline, "Campaign is over");
        // Check if contribution > 0
        require(msg.value > 0, "Contribution should be greater than 0");
        
        //adding contribution to campaign
        campaign.totalContributions += msg.value;
        campaign.contributorCount++;

        campaign.contributors[msg.sender] += msg.value;
        emit contributionMade(_campaignId, msg.sender, msg.value);
    }

    function finalizeCampaign(uint256 _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];
        // Check if campaign is finalized by its creator
        require(campaign.creator == msg.sender, "You are not the creator");
        // Creator cant end campaign if it has not ended
        require(block.timestamp >= campaign.deadline, "Campaign has not ended");
        // Creator already finalized the campaign
        require(!campaign.finalized, "Campaign is already finalized!");
        campaign.finalized = true;

        // if successful transfer totalContribution to creator
        if(campaign.totalContributions >= campaign.targetAmount) {
            payable(campaign.creator).transfer(campaign.totalContributions);
            emit campaignFinalized(_campaignId, true);
        }
        // else emit that the campaign was unsuccessful
        else {
            emit campaignFinalized(_campaignId, false);
        }
    }

    function withdraw(uint256 _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];
        // campaign has not been finalized
        require(campaign.finalized, "Campaign has not ended!");
        // campaign was successful
        require(campaign.totalContributions <= campaign.targetAmount, "Campaign was successful!");
        // contribution is 0
        require(campaign.contributors[msg.sender] != 0, "You haven't contributed to the campaign");

        // tranfer the contributed amount back to its contributor
        uint256 amount = campaign.contributors[msg.sender];
        campaign.contributors[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

}