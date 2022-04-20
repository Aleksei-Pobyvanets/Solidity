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

    // event WorkerCreated(uint index, string itemName, uint startingPrice, uint duration);
    // event WorkerTakesSalary(uint index, uint finalPrice, address winner);

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

        // uint totPay = calcTotalToPay(_workedHours, _salForHour, _absentDAys, medDays, _medicDays);
        // uint totAbs = calcAbs(_absentDAys, _medicDays, medDays);
        // uint totAbsDays = allAbsDaysFunc(_absentDAys, _medicDays);

        Sal memory newWorkerSal = Sal({
            workerName: _workerName,
            worker: _worker,
            salForHour: _salForHour,
            workedHours: _workedHours,
            absentDAys: calcAbs(_absentDAys, _medicDays, medDays),
            medicDays: medDays,
            payadSalaryAt: block.timestamp,
            toPaySal: calcTotalToPay(_workedHours, _salForHour, _absentDAys, medDays, _medicDays),
            allAbsDay: allAbsDaysFunc(_absentDAys, _medicDays),
            done: false
        });

        sals.push(newWorkerSal);

        // emit WorkerCreated(sals.length - 1, _worker, , duration); 

        pay(_worker, calcTotalToPay(_workedHours, _salForHour, _absentDAys, medDays, _medicDays));
    }

    function calcAbs(uint _absentDAys, uint _medicDays, uint medDays) private returns(uint){
        if(_medicDays > 32){
            uint absDays = _absentDAys + medDays;
            return absDays;
        }
        return _absentDAys;
    }

    function calcTotalToPay(uint _workedHours, uint _salForHour, uint _absentDAys, uint medDays, uint _medicDays) private returns(uint){
        uint perem = calcAbs(_absentDAys, _medicDays, medDays);
        uint total = _salForHour * _workedHours;
        if(perem > 20){
            total = _salForHour * (_workedHours - (perem - 20));
            return total;
        } else {
            return total;
        }
    }

    function allAbsDaysFunc(uint _absentDAys, uint _medicDays) private returns(uint){
        uint allAbsDays = _absentDAys + _medicDays;
        return allAbsDays;
    }


    function checkWorkers() private view returns(uint){
        for(uint i = 0;i < sals.length; i++){
            return sals.length;
        }
    }

    function pay(address payable worker, uint toPaySal) public payable{
        worker.transfer(toPaySal);
    }

    function takeEther() public payable {
    }
    function chackEther() public view returns(uint){
        return address(this).balance;
    }
}