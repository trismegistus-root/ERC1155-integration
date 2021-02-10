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
  bytes32 public constant BATCH_OWNER = keccak256('batchOwner');

   function addBatchOwnerRole(address _account) public onlyOwner(){
        grantRole(BATCH_OWNER, _account);         // (from OZ AccessControl)  // emits a RoleGranted(role, account, sender) event
    }

   function removeBatchOwnerRole(address _account) public onlyOwner(){
     revokeRole(BATCH_OWNER, _account);
   }

  modifier batchOwner() {
    require(hasRole(BATCH_OWNER, msg.sender));
    _;
  }

  mapping (address => uint256) internal _partition;

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
    require(Treasury.add(amount) <= cap(), "Cannot add more to Treasury than exists");
    require(_partition[_batchOwner] <= amount, "Cannot deposit more than you own");
    _transfer(_batchOwner, owner(), amount);
    Treasury = Treasury.add(amount);
    _partition[_batchOwner] = _partition[_batchOwner].sub(amount);
    if(_partition[_batchOwner] == 0){
      removeBatchOwnerRole(_batchOwner, {from: owner()});
    }
  }


  function withdrawFromTreasuryToBatch(address batch, uint256 amount) public batchOwner() {
      require(Treasury.sub(amount) >= 0, "cannot withdraw more than is in treasury");
      Treasury = Treasury.sub(amount);
      _partition[batch] = amount;
  }


  
}

