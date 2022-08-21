// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
 try / catch can only catch errors from external function calls and contract creation.
 
 * catch의 3가지 종류
    - catch Error(string memory reason) { ... } : revert 나 require를 통해 생성된 에러
    - catch Panic(uint errorCode) { ... } : assert를 통해 생성된 에러 (예: 0으로 나누면 errorcode로 0x12를 리턴)
    - catch(bytesmemoryLowLevelData) { ... } : 로우 레벨 에러

  * 어디서 사용하는가?
    (1) 외부 스마트 컨트랙트 함수를 호출할 때 : 다른 스마트 컨트랙트를 인스턴스화 한 뒤, 인스턴스로 함수 호출할 때 사용
    (2) 외부 스마트 컨트랙트를 생성할 때 : 다른 스마트 컨트랙트를 인스턴스화 생성할 때 사용함
    (3) 스마트 컨트랙트 내에서 함수를 부를 때 : this를 통해 try/catch를 사용함
*/

// External contract used for try / catch examples
contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        // This Foo contract is used for example of try catch with external call
        foo = new Foo(msg.sender);
    }

    // Example of try / catch with external call
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    // Example of try / catch with contract creation
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            // you can use variable foo here
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }
}
