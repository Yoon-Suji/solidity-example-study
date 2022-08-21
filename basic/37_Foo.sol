// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
Here is our folder structure.

├── Import.sol
└── Foo.sol

*/

struct Point {
    uint x;
    uint y;
}

error Unauthorized(address caller);

function add(uint x, uint y) pure returns (uint) {
    return x + y;
}

contract Foo {
    string public name = "Foo";
}
