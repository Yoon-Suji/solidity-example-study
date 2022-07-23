// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
  Immutable variables are like constants.
  Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
*/

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}

/*
  - 상태 변수는 constant 또는 immutable로 선언할 수 있습니다.
  - constant는 컴파일시에 값이 결정되고, immutable은 생성 시에 결정(생성자에서 설정)됩니다. 값이 결정되고 나면 둘 다 변경할 수 없습니다.
  - constant는 파일 수준에서 정의할 수도 있습니다. 별도 파일에 constant만을 모아서 작성할 수 있다는 것입니다.
  - 컴파일러는 이들에 대해서 직접 값으로 대체하기 때문에 저장소를 할당할 필요가 없기 때문에 효율적입니다.
  - 현재 값 타입과 string에만 사용할 수 있습니다. string은 constant만 가능합니다.
/*
