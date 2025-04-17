// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    uint256 public constant MAX_NUMBER = 1000;

    error NumberTooLargeError();

    function setNumber(uint256 newNumber) public {
        if (newNumber > MAX_NUMBER) {
            revert NumberTooLargeError();
        }
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
