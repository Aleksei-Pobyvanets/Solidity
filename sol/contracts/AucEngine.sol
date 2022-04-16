//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract AucEngine {
    address public owner;
    uint constant DURATION = 2 days;
    uint constant FEE = 10;

    struct Auction {
        address payable seller;
        uint startingPrice;
        uint startAt;
        uint endsAt;
        uint discauntRate;
        string item;
        bool stoped;
    }

    Auction[] public auctions;

    event AuctionCreated(uint index, string itemName, uint startingPrice, uint duration);

    constructor() {
        owner = msg.sender;
    }


    function createAuction(uint _startingPrice, uint _discountRate, string calldata _item, uint _duration) external {
        uint duration = _duration == 0 ? DURATION : _duration; //if else 

        require(_startingPrice >= _discountRate * duration, "Incorect price");

        Auction memory newAuction = Auction({
            seller: payable(msg.sender),
            startingPrice: _startingPrice,
            finalPrice: _startingPrice,
            discountRate: _discountRate,
            startAt: block.timestamp,
            endsAt: block.timestamp + duration,
            item: _item,
            stoped: false
        });
        auctions.push(newAuction);

        emit AuctionCreated(auctions.length - 1, _item, _startingPrice, _duration);
    }
}