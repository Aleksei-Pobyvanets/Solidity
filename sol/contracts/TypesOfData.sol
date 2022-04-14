//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract TypesOfData {

    // address public addrZ;

    // function newStr(address newaddr) public {
    //     addrZ = newaddr;
    // }


    address public addrZ;
    uint public uintZ;

    mapping(uint => address) public mappPeo;

    function newStr(address newaddr, uint newuint) public {
        addrZ = newaddr;
        uintZ = newuint;
        mappPeo[uintZ] = addrZ;
    }
}
   