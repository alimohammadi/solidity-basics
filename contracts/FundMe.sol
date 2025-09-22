// Get funds from user
// Widraw funds
// Set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import {PriceConverter} from "./PriceConvertor.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns (uint256) {
        // AggregatorV3Interface();
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed =  AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
       (,int256 price,,,) =  priceFeed.latestRoundData(); // Price of ETH in terms of USD
        
        return uint256(price) *1e10;
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        // 1 ETH?
        // 2000_000000000000000000
        uint256 ethPrice = getPrice();

        // (2000_000000000000000000 * 1_000000000000000000) / 1e18
        // 2000 $ = 1 ETH
        uint256 ethAmountInUSD =  (ethPrice * ethAmount) / 1e18;

        return ethAmountInUSD;
    }

    function getVersion() internal view returns (uint256){
      return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
}
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

// constant, immutable => reduce the gas cost

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;
    uint256 public constant MIINIMUM_USD = 5 * 1e18;// using constant keyword reduce the gas size

    address[] public funders;
    mapping(address founder=>uint256 amountFunded) public addressToAmountFounded;

    // function callMeRightAway(params) public{}
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable{
        // Allow user to send money
        // Have a minimum $ sent

        // How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= MIINIMUM_USD, "didn't send enough ETH"); // 1e18 = 1 ETH
        // msg.value.getConversionRate();

        funders.push(msg.sender);
        addressToAmountFounded[msg.sender] += msg.value;
        // What is revert?
        // Undo any actions that have been done, and send the remaining gas back
        // If you send fail transaction you spent gas
    }


    function withdraw() public onlyOwner {
        require(msg.sender == i_owner, "Must be owner");

        // for loop
        for (uint256 funderIndx = 0; funderIndx < funders.length; funderIndx++) 
        {
           address funder = funders[funderIndx];
           addressToAmountFounded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // withdraw the funds

        // transfer 
        // msg.sender <=> address, payable(msg.sender) <=> payable address
        // payable(msg.sender).transfer(address(this).balance);

        // send 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        
        // call
       (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}("");

       require(callSuccess, "Call failed");
    }

    modifier onlyOwner(){
        // Fist call this
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        // require(msg.sender == i_owner, "Sender is not owner!");
        // then add other parts(The order of _ is matter)
        _;
    }

    // What happen if someone sends this contract ETH without calling the fund function
    receive() external payable {
        fund();
    }

    fallback() external payable { 
        fund();
    }
}

