//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract hello {
    uint public value;
    constructor(uint _input) {
        value = _input;
    }
}

contract helloA is hello(12){

}

contract holl1 {
    function Parent() public pure virtual returns(uint){
        return 92;
    }
}

contract holl2 is holl1 {
    function Parent() public pure override returns(uint){
        uint result = holl1.Parent();
        return result * 2;
    }
}