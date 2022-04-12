//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract payments {

    function receivFunds() external payable {
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawFunds(address payable _to) external {
        require(address(this).balance > 0 ether, "Error");
        _to.transfer(address(this).balance);
    }
    
}