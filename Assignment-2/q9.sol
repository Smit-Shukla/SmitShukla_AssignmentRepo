// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLedger {
    // Simple Transaction information
    struct Transaction {
        address sender;
        address receiver;
        uint256 amount;
        uint256 timestamp;
    }

    // Array of Transaction
    Transaction[] public ledger;

    // Adds the Transaction by pushing it to ledger
    function addTransaction(address receiver, uint256 amount) public {
        address sender = msg.sender;
        ledger.push(Transaction(sender, receiver, amount, block.timestamp));
    }

    // view ledger
    function getLedger() public view returns (Transaction[] memory) {
        return ledger;
    }
}