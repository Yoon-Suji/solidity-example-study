// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
  view : function 밖의 변수들을 읽을수 있으나 변경 불가능
  pure : function 밖의 변수들을 읽지 못하고, 변경도 불가능
*/

contract IfElse {
    function foo(uint x) public pure returns (uint) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint _x) public pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;

        // shorthand way to write if / else statement
        // the "?" operator is called the ternary operator
        return _x < 10 ? 1 : 2;
    }
}
