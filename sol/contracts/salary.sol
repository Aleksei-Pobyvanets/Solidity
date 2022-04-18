//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract paySalary {

    address owner = msg.sender;
    // uint salForJunForHour = 1 ether;
    // uint salForMidForHour = 2 ether;
    // uint salForSinForHour = 3 ether;

    struct Sal {
        address payable worker;
        uint salForHour;
        uint workedHours;
        uint absentDAys;
        uint medicDays;
        uint payadSalaryAt;
    }

    Sal[] public sals;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not an owner");
        _;
    }

    function createWorkersSal(uint _salForHour, address payable _worker, uint _workedHours, uint _absentDAys, uint _medicDays) external onlyOwner{
        require(_salForHour > 0, "Invalid salary");
        require(_workedHours > 0, "Invalid worked hours");

        Sal memory newWorkerSal = Sal({
            worker: _worker,
            salForHour: _salForHour,
            workedHours: _workedHours,
            absentDAys: _absentDAys,
            medicDays: _medicDays,
            payadSalaryAt: block.timestamp
        });
        
        sals.push(newWorkerSal);
        
    }
}