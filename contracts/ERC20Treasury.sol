// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

contract ERC20Treasury is ERC20Capped, Ownable{
  using SafeMath for uint256;

  uint256 Treasury;

  constructor(string memory _name, 
              string memory _symbol, 
              uint256 _cappedSupply,
              uint256 _initialTreasury)

  ERC20Capped(_cappedSupply)
  ERC20(_name, _symbol)
  Ownable() public {
    /**Treasury contract 
    1. Sets cap 
    2. Sets name
    3. Sets treasury supply as portion of total capped ERC20 */
    Treasury = _initialTreasury;
    _mint(owner(), _initialTreasury);
  }

  function totalTreasury() public view returns(uint256){
    return Treasury;
  }

  function _increaseTreasuryFromSupply(uint256 amount) internal onlyOwner(){
    require((Treasury + amount) < cap(), "Cannot increase Treasury beyond capped supply");
    Treasury = (Treasury + amount);
    _mint(owner(), amount); //need a separate function for deposit//
  }

  function _increaseTreasuryFromDeposit(uint256 amount) internal onlyOwner(){
    require((Treasury + amount) < cap(), "Cannot increase Treasury beyond capped supply");
    Treasury = (Treasury + amount);
  }

  function _decreaseTreasury(uint256 amount) internal onlyOwner(){
    require((Treasury - amount) >= 0, "Cannot decrease Treasury lower than zero");
    Treasury = (Treasury - amount);
  }

  function withdrawFromTreasury(address batch, uint256 amount) public onlyOwner(){
    require((Treasury - amount) >= 0, "Cannot decrease Treasury lower than zero");
    _decreaseTreasury(amount);
    _transfer(owner(), batch, amount);
  }

  function depositToTreasury(address batch, uint256 amount) public onlyOwner(){
    require((Treasury + amount) < cap(), "Cannot increase Treasury beyond capped supply");
    _increaseTreasuryFromDeposit(amount);
    _transfer( batch, owner(), amount);
  }
  
}

