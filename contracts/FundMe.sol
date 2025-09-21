// Get funds from user
// Widraw funds
// Set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConvertor.sol";

// solhint-disable-next-line interface-starts-with-i
// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }


contract FundMe{
    using PriceConverter for uint256;
    uint256 public minimumUsd = 5 * 1e18;

    address[] public funders;
    mapping(address founder=>uint256 amountFunded) public addressToAmountFounded;

    function fund() public payable{
        // Allow user to send money
        // Have a minimum $ sent

        // How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH
        // msg.value.getConversionRate();

        funders.push(msg.sender);
        addressToAmountFounded[msg.sender] += msg.value;
        // What is revert?
        // Undo any actions that have been done, and send the remaining gas back
        // If you send fail transaction you spent gas

    }

    function withdraw() public payable {
        // for loop
        for (uint256 funderIndx = 0; funderIndx <= funders.length; funderIndx++) 
        {
           address funder = funders[funderIndx];
           addressToAmountFounded[funder] = 0;
        }
    }
}

