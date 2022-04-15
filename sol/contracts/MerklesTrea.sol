//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Tree {

    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Bob -> Gretta",
        "TX1: Gretta -> Bob",
        "TX1: Igor -> Ivan",
        "TX1: Ivan -> Igor"
    ];

    function encode(string memory input) public pure returns(bytes memory){
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns(bytes32){
       return  keccak256(encode(input));
    }
    

    constructor() {
        for(uint i = 0; i < transactions.length; i ++){
            hashes.push(makeHash(transactions[i]));
        }
    }
}