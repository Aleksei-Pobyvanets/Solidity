//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract AucEngine {
    address public owner;
    uint constant DURATION = 2 days;
    uint constant FEE = 10;

    struct Auction {
        address payable seller;
        uint startingPrice;
        uint sartAt;
        uint endsAt;
        uint discauntRate;
        string item;
        bool stoped;
    }

    Auction[] public auctions;

    constructor() {
        owner = msg.sender;
    }
}