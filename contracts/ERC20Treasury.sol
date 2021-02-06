// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract ERC20Treasury is ERC20Capped, Ownable{

  uint256 Treasury;

  constructor(string memory _name, 
              string memory _symbol, 
              uint256 _cappedSupply,
              uint256 _initialTreasury)

  ERC20Capped(_cappedSupply)
  ERC20(_name, _symbol)
  Ownable() public{
    /**Treasury contract 
    1. Sets cap 
    2. Sets name
    3. Sets treasury supply as portion of total ERC20 */
    Treasury = _initialTreasury;
    _mint(owner(), Treasury);
  }

  function totalTreasury() public view returns(uint256){
    return Treasury;
  }

  function increaseTreasury(uint256 amount) public onlyOwner(){
    require((Treasury + amount) < cap(), "Cannot increase Treasury beyond capped supply");
    Treasury += (Treasury + amount);
    _mint(owner(), amount); 
  }

  function decreaseTreasury(uint256 amount) public onlyOwner(){
    require((Treasury - amount) > 0, "Cannot decrease Treasury lower than zero");
    Treasury = (Treasury - amount);
  }

  function withdrawFromTreasury(address batch, uint256 amount) public onlyOwner(){
    require((Treasury - amount) > 0, "Cannot decrease Treasury lower than zero");
    decreaseTreasury(amount);
    transferFrom(owner(), batch, amount);
  }

  function depositToTreasury(address batch, uint256 amount) public onlyOwner(){
    require((Treasury + amount) < cap(), "Cannot increase Treasury beyond capped supply");
    increaseTreasury(amount);
    transferFrom(batch, owner(), amount);
  }
}

