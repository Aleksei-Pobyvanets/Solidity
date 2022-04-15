//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract eve{

    event PayableEv(address _from, uint _amount, uint _timestamp);

    function pay() external payable{
        emit PayableEv(msg.sender, msg.value, block.timestamp);
    }

}