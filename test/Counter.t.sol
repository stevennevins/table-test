// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2 as console} from "forge-std/Test.sol";
import {TableTest} from "./TableTest.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is TableTest {
    struct Case {
        uint256 input;
        uint256 expected;
    }

    struct FailureCase {
        uint256 input;
        bytes4 expectedError;
    }

    Case[] internal cases;
    Case internal c;

    FailureCase[] internal failureCases;
    FailureCase internal fc;

    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function setupCases() public {
        cases.push(Case(0, 1));
        cases.push(Case(1, 2));
        cases.push(Case(5, 6));
        cases.push(Case(100, 101));
        tableLength = cases.length;
    }

    function testTable_Increment() public tableTest(setupCases) {
        c = cases[tableTestIndex];

        counter.setNumber(c.input);
        counter.increment();

        console.log(counter.number());
        assertEq(counter.number(), c.expected, "Increment calculation incorrect");
    }

    function setupFailureCases() public {
        failureCases.push(FailureCase(counter.MAX_NUMBER() + 1, Counter.NumberTooLargeError.selector));
        failureCases.push(FailureCase(type(uint256).max, Counter.NumberTooLargeError.selector));
        tableLength = failureCases.length;
    }

    function testTable_SetNumber_failures() public tableTest(setupFailureCases) {
        fc = failureCases[tableTestIndex];
        vm.expectRevert(fc.expectedError);
        counter.setNumber(fc.input);
    }
}
