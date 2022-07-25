// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/*
  You can define your own type by creating a struct.
  They are useful for grouping together related data.
  Structs can be declared outside of a contract and imported in another contract.
*/

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;
    
    /*
      Memory : 함수 호출시에만 존재하는 휘발성 데이터가 위치하는 곳
      Calldata : Call에 사용되는 Data, 함수 호출시 인자로 포함된 데이터들이 위치하는 공간.
      - Memory는 수정이 가능하지만 Calldata는 수정이 불가
      - Calldata는 Calldata에 포함된 데이터를 사용, memory는 calldata로부터 데이터를 가져와서 별도의 카피본을 만들어서 사용.
      - memory를 사용하면 calldata에 비해서 가스비가 더 발생함
      =>  읽기와 수정이 필요하지만 블록체인 상태 업데이트는 필요없는 경우 (블록체인에 기록하지 않음) memory를 사용, 함수 파라미터로 calldata 키워드를 사용하면 가스비를 아낄 수 있음.
    */

    function create(string calldata _text) public {
        // 3 ways to initialize a struct
        // - calling it like a function
        todos.push(Todo(_text, false));

        // key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text;
        // todo.completed initialized to false

        todos.push(todo);
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
