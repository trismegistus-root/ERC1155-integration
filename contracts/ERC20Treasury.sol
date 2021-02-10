// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/access/AccessControl.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/math/SafeMath.sol';

contract ERC20Treasury is ERC20Capped, Ownable, AccessControl{
  using SafeMath for uint256;

  uint256 public Treasury;
  uint256 public Bonds;
  uint256 public UnmintedSupply;

   function addBatchOwnerRole(address _account) public  onlyOwner(){
        grantRole("batchOwner", _account);         // (from OZ AccessControl)  // emits a RoleGranted(role, account, sender) event
    }

   function removeBatchOwnerRole(address _account) public onlyOwner(){
     revokeRole("batchOwner", _account);
   }

  modifier batchOwner() {
    require(hasRole("batchOwner", msg.sender));
    _;
  }

  constructor(string memory _name, 
              string memory _symbol, 
              uint256 _cappedSupply,
              uint256 _initialTreasury)

  ERC20Capped(_cappedSupply)
  ERC20(_name, _symbol)
  Ownable()
  AccessControl() public {
    /**Treasury contract 
    1. Sets cap 
    2. Sets name
    3. Sets treasury supply as portion of total capped ERC20 */
    Treasury = _initialTreasury;
    _mint(msg.sender, _initialTreasury);
    Bonds = _cappedSupply.sub(Treasury);
    UnmintedSupply = cap().sub(totalSupply());
  }
/**Total treasury is a portion of the total cap of ERC20 token.
  *Cap() - totalTreaury() = Bonds()
  *Bonds represent the DEX swappable token. Bonds are the supply of ERC20 that has not been locked for distribution.
  *
  */
  function totalTreasury() public view returns(uint256){
    return Treasury;
  }

  /**Bonds represent the DEX swappable token. Bonds are the supply of ERC20 that has not been locked for distribution. */
  function totalBonds() public view returns(uint256){
    return Bonds;
  }

  function availableBonds() public view returns(uint256){
    return UnmintedSupply;
  }

  /**Reduces number of available Bonds for DEX but increases Treasury 
     Requires that unminted bonds be greater than the amount requested.
     mints bonds
     adds bonds to available treasury
  */
  function increaseTreasuryFromUnmintedBonds(uint256 amount) public onlyOwner() {
     require(amount < UnmintedSupply, "Not enough unminted bonds to cover deposit");
     _mint(owner(), amount);
     Treasury = Treasury.add(amount);
  }

  function increaseTreasuryFromBatch(address _batchOwner, uint256 amount) public batchOwner() {
    require(balanceOf(_batchOwner) >= amount, "You cannot deposit funds you do not own");
    require(Treasury.add(amount) <= cap(), "Cannot add more to Treasury than exists");
    _transfer(_batchOwner, owner(), amount);
    Treasury = Treasury.add(amount);
    removeBatchOwnerRole(_batchOwner);
  }


  function partitionDecreaseTreasury(uint256 amount) internal {
    /**Require:
        1. amount >= 0
        2. treasury.sub(amount) >= 0
        3. amount <= Treasury
         */
         require(amount >= 0 && amount <= Treasury, "Invalid amount requested");
         require(Treasury.sub(amount) >= 0, "Amount requested brings Treasury below 0");
         Treasury = Treasury.sub(amount);
  }


  
}

