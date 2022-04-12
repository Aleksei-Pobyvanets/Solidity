//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract ArrayStruct {

    enum Statuses {Unpayed, Payed, Shipped}

    struct Payment {
        uint amount;
        uint timestamp;
    }

    uint public takenEth;

    Payment[] public payments;

    Statuses status;

    function check() public {  //Проверить статус
        require(status == Statuses.Payed, "Not norm stat");
    }

    function payFunc() public payable{ //проверка на пустоту транзы и запись в истоиию
        takenEth = msg.value;
        require(takenEth > 0, "Empty");
        Payment memory payment = Payment(msg.value, block.timestamp);
        payments.push(payment);
    }

    function withdrawAll(address payable _to) public { // вывод с проверкой полная ли стоемость оплачена
        uint total;
        for(uint i = 0; i < payments.length; i++){
            total += payments[i].amount;
        }
        require(total >= 5 ether, "Pay More Stupid");
            _to.transfer(total);
            status = Statuses.Payed;
    }

    function getBalance() public view returns(uint){ //Проверка баланса
        return address(this).balance;
    }
}