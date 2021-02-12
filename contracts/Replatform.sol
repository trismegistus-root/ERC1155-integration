// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC20Treasury.sol';
import '@openzeppelin/contracts/token/ERC1155/IERC1155MetadataURI.sol';
import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';

contract Replatform is ERC20Treasury, ERC1155{ 

  constructor(string memory nameOfTreasury, 
              string memory symbolOfTreasury, 
              uint256 cappedSupplyOfTreasury,
              uint256 initialAvailableSupplyOfTreasury) 
  ERC20Treasury(nameOfTreasury, symbolOfTreasury, cappedSupplyOfTreasury, initialAvailableSupplyOfTreasury)
  ERC1155("./../URI/URI.json") public {}


    function batch(address to, uint256 id, uint256 amount, bytes memory data) public batchOwner(){
      require(amount <= totalTreasury(), "Cannot withdraw more to batch than is available in treasury");
      require(amount <= 1, "1 per wallet");
      require(_partition[to] == 0);
      withdrawFromTreasuryToBatch(amount);
      ERC1155._mint(to, id, amount, data);
    }
    
  
  
}
