//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract paySalary {

    address owner = msg.sender;
    // uint salForJunForHour = 1 ether;
    // uint salForMidForHour = 2 ether;
    // uint salForSinForHour = 3 ether;

    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    struct Sal {
        string workerName;
        address payable worker;
        uint salForHour;
        uint workedHours;
        uint absentDAys;
        uint medicDays;
        uint payadSalaryAt;
        uint toPaySal;
        uint allAbsDay;
        bool done;
    }

    Sal[] public sals;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not an owner");
        _;
    }

    function createWorkersSal(string memory _workerName, uint _salForHour, address payable _worker, uint _workedHours, uint _absentDAys, uint _medicDays) external onlyOwner{
        require(_salForHour > 0, "Invalid salary");
        require(_workedHours > 0, "Invalid worked hours");
        

        uint medDays = _medicDays > 32 ? _medicDays - 32: _medicDays;



        Sal memory newWorkerSal = Sal({
            workerName: _workerName,
            worker: _worker,
            salForHour: _salForHour,
            workedHours: _workedHours,
            absentDAys: calcAbs(_absentDAys, _medicDays, medDays),
            medicDays: medDays,
            payadSalaryAt: block.timestamp,
            toPaySal: _workedHours * _salForHour,
            allAbsDay: allAbsDaysFunc(_absentDAys, _medicDays),
            done: false
        });

        sals.push(newWorkerSal);
    }

    function calcAbs(uint _absentDAys, uint _medicDays, uint medDays) public returns(uint){
        if(_medicDays > 32){
            uint absDays = _absentDAys + medDays;
            return absDays;
        }
        return _absentDAys;
    }

    function allAbsDaysFunc(uint _absentDAys, uint _medicDays) public returns(uint){
        uint allAbsDays = _absentDAys + _medicDays;
        return allAbsDays;
    }


    function checkWorkers() public view returns(uint){
        for(uint i = 0;i < sals.length; i++){
            return sals.length;
        }
    }

    

}