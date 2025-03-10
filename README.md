## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Table Tests

Table tests provide a structured way to test multiple scenarios with different inputs and expected outputs. They are particularly useful for:

- Testing multiple input combinations
- Validating boundary conditions
- Testing state transitions
- Reducing test code duplication

### Quick Start

1. Inherit from `TableTest`
2. Define your test case struct
3. Create an array to store test cases
4. Implement `tableLength()` so the modifier can iterate through cases
5. Write your test function with the `tableTest` modifier

```solidity
contract MyTest is TableTest {
    struct Case {
        uint256 input;
        uint256 expected;
    }

    Case[] internal cases;
    Case internal c;

    function setupCases() public {
        cases.push(Case(1, 2));  // Case 0
        cases.push(Case(2, 4));  // Case 1
    }

    function testTable_Double() public tableTest(setupCases) {
        c = cases[tableTestIndex];  // Get current case
        uint256 result = c.input * 2;
        assertEq(result, c.expected);
    }

    function tableLength() internal view override returns (uint256) {
        return cases.length;
    }
}

/*
Iteration Flow:
┌────────────────────┐
│ tableTest modifier │
└─────────┬──────────┘
          │
          ▼
┌─────────────────────┐    ┌──────────-───┐
│ Case 0: input = 1   │ => │ expected = 2 │
└─────────────────────┘    └─────────-────┘
          │
          ▼
┌─────────────────────┐    ┌────────────-─┐
│ Case 1: input = 2   │ => │ expected = 4 │
└─────────────────────┘    └────────────-─┘

Each iteration:
1. Takes snapshot
2. Runs test with current case
3. Reverts to snapshot
4. Moves to next case
*/
```

### When to Use Table Tests

Use table tests when you need to:

- Test multiple input/output combinations
- Validate state transitions
- Test boundary conditions
- Reduce duplicate test code
- Maintain organized test cases

### Best Practices

1. Keep test cases focused and minimal
2. Use descriptive struct fields
3. Group related test cases together

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
