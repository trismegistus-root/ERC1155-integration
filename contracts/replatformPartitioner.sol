// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/presets/ERC1155PresetMinterPauser.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract replatform is ERC20Capped, Ownable{
    uint256 public _MAX_SUPPLY;
    uint256 public _TOTAL_TREASURY;
    string public _name;
    string public _symbol;

  constructor(uint256 MAX_SUPPLY, uint256 TOTAL_TREASURY, string memory name, string memory symbol) 
    ERC20Capped(_MAX_SUPPLY) //Sets max token supply to 10,000 with 18 decimals
    ERC20(_name, _symbol)
    Ownable(){
      _MAX_SUPPLY = MAX_SUPPLY;
      _TOTAL_TREASURY = TOTAL_TREASURY;
      _name = name;
      _symbol = symbol;
    } 
 
    
    function increaseTreasury(uint256 amount) public onlyOwner(){
      _TOTAL_TREASURY += _TOTAL_TREASURY + amount;
    }

    function totalTreasury()public view returns(uint256){
      return _TOTAL_TREASURY;
    }
}


contract replatformPartitioner is replatform, ERC1155PresetMinterPauser{
  constructor()
  replatform(10000 ether, 20000000000, "Replatform", "NGMI")
  ERC1155PresetMinterPauser(" "){}
  
  //this ties the number of mintable ERC1155s to the treasury of the replatform token
  uint256 LIMITER = totalTreasury();

  
}
