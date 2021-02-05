// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import './replatformPartitioner.sol';

contract replatform is ERC20Capped, Ownable{
    uint256 public MAX_SUPPLY;
    uint256 public TOTAL_TREASURY;
    string public _name;
    string public _symbol;

  constructor(MAX_SUPPLY, TOTAL_TREASURY, _name, _symbol) 
    ERC20Capped(MAX_SUPPLY) //Sets max token supply to 10,000 with 18 decimals
    ERC20(_name, _symbol)
    Ownable(){} //Sets name to Replatform, symbol to NGMI

    //function to funnel by 18th decimal into partitioner
    function increaseTreasury(uint256 amount) public onlyOwner(){
      TOTAL_TREASURY += TOTAL_TREASURY + amount;
    }
}
