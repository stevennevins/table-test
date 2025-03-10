// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TableTest} from "./TableTest.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is TableTest {
    struct Case {
        uint256 input;
        uint256 expected;
    }

    Case[] internal cases;
    Case internal c;
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function setupIncrementCases() public {
        cases.push(Case(0, 1));
        cases.push(Case(1, 2));
        cases.push(Case(5, 6));
        cases.push(Case(100, 101));
    }

    function testTable_Increment() public tableTest(setupIncrementCases) {
        c = cases[tableTestIndex];

        counter.setNumber(c.input);
        counter.increment();

        assertEq(counter.number(), c.expected, "Increment calculation incorrect");
    }

    function tableLength() internal view override returns (uint256) {
        return cases.length;
    }
}
