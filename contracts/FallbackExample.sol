// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract FallbackExample {
    uint256 public result;

    // recieve function call every time you call functions also empty amount transfering
    receive() external payable {
        result = 1;

    }

    fallback() external payable {
        result = 2;
    }
}


// is msg.data exmpty?
//       /        \
//     Yes         No
//      /           \
//  recieve()?      fallback()
//    /     \
//  Yes      No
//   |         \
// recieve() fallback()