//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract ArrayStruct {

    enum Statuses {Unpayed, Payed, Shipped}

    Statuses status;

    function check() public { //проверяет статус
        status = Statuses.Payed;
        require(status == Statuses.Payed, "Status wrong");
        status = Statuses.Shipped; 
    }

    struct Payment { // структура, в ней храниться история транзакций.
        uint amount;
        uint timestamp;
    }

    Payment[] public payments; //обьявление для простого использования

    function simple() public payable{ // Функция для закидывания на контракт и записи в историю и показывания её
        Payment memory payment = Payment(msg.value, block.timestamp);
        payments.push(payment);
    }

    function withdrawAll(address payable _to) public{ // Функция для снятия сразу всеё суммы с контракта, со всех записей за раз
        uint total;
        for(uint i = 0; i < payments.length; i++){
            total += payments[i].amount;
        }
        _to.transfer(total);
    }
}