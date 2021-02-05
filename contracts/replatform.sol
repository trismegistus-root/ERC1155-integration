// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import './replatformPartitioner.sol';

contract replatform is ERC20Capped, Ownable{
    uint256 MAX_SUPPLY = 10000;

  constructor() 
    ERC20Capped(MAX_SUPPLY) //Sets max token supply to 10,000 with 18 decimals
    ERC20("Replatform", "NGMI"){} //Sets name to Replatform, symbol to NGMI

    //function to mint total supply to contract
    //function to funnel by 18th decimal into partitioner
}
