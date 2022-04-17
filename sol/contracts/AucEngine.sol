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
    event AuctionEnded(uint index, uint finalPrice, address winner);

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

    function getPriceFor(uint index) public view returns(uint) {
        Auction memory cAuction = auctions[index];
        require(!cAuction.stoped, "Stoped");
        uint elapsed = block.timestamp - cAuction.startAt; 
        uint discount = cAuction.discauntRate * elapsed;
        return cAuction.startingPrice - discount;
    } 

    function buy(uint index) external payable {
        Auction memory cAuction = auctions[index];
        require(!cAuction.stoped, "Stoped");
        require(block.timestamp < cAuction.endsAt, "Already stoped");
        uint cPrice = getPriceFor(index);
        require(msg.value >= cPrice, "not enough");
        cAuction.stoped = true;
        cAuction.finalPrice = cPrice;
        uint refund = msg.value - cPrice;
            if(refund > 0) {
                payable(msg.sender).transfer(refund);
            }
        cAuction.seller.transfer(
            cPrice - ((cPrice * FEE) / 100)
        );

            emit AuctionEnded(index, cPrice, msg.sender);
    }
}