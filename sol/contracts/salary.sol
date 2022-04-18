//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract paySalary {

    address owner = msg.sender;
    uint salForJunForHour = 1 ether;
    uint salForMidForHour = 2 ether;
    uint salForSinForHour = 3 ether;

    struct sal {
        address worker;
        uint position;
    }

    uint workHours;

    modifier onlyOwner() {
        require(owner == msg.sender, "Not an owner");
        _;
    }

    function createWorker(uint _position, uint _salForHour, address _worker) external onlyOwner{

    }
}