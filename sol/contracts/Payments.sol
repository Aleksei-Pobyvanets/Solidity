//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract payments {
    uint carrentBalance;

    function receivFunds() external payable {
        carrentBalance = carrentBalance + msg.value;
    }
    function getBalance() public view returns(uint) {
        return carrentBalance;
    }
    function withdrawFunds(address payable _to) external {
        _to.transfer(carrentBalance);
        carrentBalance = 0;
    }
}