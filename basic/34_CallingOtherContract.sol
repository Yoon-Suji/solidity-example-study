// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
  Contract can call other contracts in 2 ways.
  The easiest way to is to just call it, like A.foo(x, y, z).

  Another way to call other contracts is to use the low-level call.
  This method is not recommended.
  
  
*/

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

/*
  - Callee의 컨트랙트 주소를 Callee _callee, address _addr의 형태로 가져올  수 있음
   (불러온 방식에 따라서 함수 내 사용법 조금 상이함)
  - 마지막 Call 함수 사용은 추천하지 않음(setXandSendEther)
*/

contract Caller {
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint _x) public payable {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
    }
}
