// Get funds from user
// Widraw funds
// Set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FundMe{
    function fund() public payable{
        // Allow user to send money
        // Have a minimum $ sent

        // How do we send ETH to this contract?
        require(msg.value > 1e18, "didn't send enough ETH"); // 1e18 = 1 ETH
    }

    // function withdraw() public payable {}

}

