// Get funds from user
// Widraw funds
// Set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


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

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    
    uint256 public minimumUsd = 5;

    function fund() public payable{
        // Allow user to send money
        // Have a minimum $ sent

        // How do we send ETH to this contract?
        require(msg.value >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH

        // What is revert?
        // Undo any actions that have been done, and send the remaining gas back
        // If you send fail transaction you spent gas

    }

    // function withdraw() public payable {}

    function getPrice() public view returns (uint256) {
        // AggregatorV3Interface();
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed =  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       (,int256 price,,,) =  priceFeed.latestRoundData(); // Price of ETH in terms of USD
        
        return uint256(price) *1e10;
    }

    function getConvertionRate(uint256 ethAmount) public view returns (uint256){
        // 1 ETH?
        // 2000_000000000000000000
        uint256 ethPrice = getPrice();

        // (2000_000000000000000000 * 1_000000000000000000) / 1e18
        // 2000 $ = 1 ETH
        uint256 ethAmountInUSD =  (ethPrice * ethAmount) / 1e18;

        return ethAmountInUSD;
    }

    function getVersion() public view returns (uint256){
      return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}

