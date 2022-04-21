//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract paySalary {

    address owner = msg.sender;

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

        uint salInEth = 0 ether;
        salInEth = _salForHour;


        Sal memory newWorkerSal = Sal({
            workerName: _workerName,
            worker: _worker,
            salForHour: salInEth,
            workedHours: _workedHours,
            absentDAys: calcAbs(_absentDAys, _medicDays, medDays),
            medicDays: medDays,
            payadSalaryAt: block.timestamp,
            toPaySal: calcTotalToPay(_workedHours, salInEth, _absentDAys, medDays, _medicDays),
            allAbsDay: allAbsDaysFunc(_absentDAys, _medicDays),
            done: false
        });

        sals.push(newWorkerSal);

        // emit WorkerCreated(sals.length - 1, _worker, , duration); 

        // pay(_worker, calcTotalToPay(_workedHours, _salForHour, _absentDAys, medDays, _medicDays));
    }

    function calcAbs(uint _absentDAys, uint _medicDays, uint medDays) public returns(uint){
        if(_medicDays > 32){
            uint absDays = _absentDAys + medDays;
            return absDays;
        }
        return _absentDAys;
    }

    function calcTotalToPay(uint _workedHours, uint salInEth, uint _absentDAys, uint medDays, uint _medicDays) public returns(uint){
        uint perem = calcAbs(_absentDAys, _medicDays, medDays);
        uint total = 0 ether;
        total = salInEth * _workedHours;
        if(perem > 20){
            total = salInEth * (_workedHours - (perem - 20));
            return total;
        } else {
            return total;
        }
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

    function paySal(uint index) public payable onlyOwner{
        address payable takenAdd;
        uint takenSal;
        for(uint i = 0; i < sals.length; i++){
            takenAdd = sals[index].worker;
            takenSal = sals[index].toPaySal;
        }

        takenAdd.transfer(takenSal);
    }

    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db -- 1
    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 -- 2/1
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db -- 3/2



    function takeEther() public payable {
    }
    function chackEther() public view returns(uint){
        return address(this).balance;
    }
}