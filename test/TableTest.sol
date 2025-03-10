// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2 as console} from "forge-std/Test.sol";

abstract contract TableTest is Test {
    uint256 internal tableTestIndex;

    function tableLength() internal virtual returns (uint256);

    modifier tableTest(function() internal setUp) {
        setUp();

        uint256 numCases = tableLength();
        for (uint256 i; i < numCases; i++) {
            console.log("Running scenario", i + 1);
            tableTestIndex = i;
            uint256 snapshot = vm.snapshotState();
            _;
            vm.revertToState(snapshot);
        }
    }
}
