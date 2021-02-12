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

    mapping(uint256 => uint256) internal communityId;
    mapping(uint256 => address) internal communityOwner;

    function batch(address to, uint256 id, uint256 amount, bytes memory data) public batchOwner(){
      require(amount <= totalTreasury(), "Cannot withdraw more to batch than is available in treasury");
      require(_partition[to] == 0);
      withdrawFromTreasuryToBatch(amount);
      ERC1155._mint(to, id, amount, data);
      communityId[id] = amount; //sets amount to community fund
      communityOwner[id] = to; //sets address of owner
    }

    function joinCommunity(uint256 id){
      require(communityId[id] > 0, "Community has reached capacity");
      safeTransferFrom(communityOwner[id], msg.sender, 1, 1);
    }
     


  
}
