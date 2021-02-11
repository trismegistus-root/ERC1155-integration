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
  
  
  
}
