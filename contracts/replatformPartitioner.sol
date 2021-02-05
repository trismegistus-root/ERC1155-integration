// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/presets/ERC1155PresetMinterPauser.sol';
import './replatform.sol';

contract replatformPartitioner is ERC1155PresetMinterPauser, replatform{
  constructor() public
  ERC1155PresetMinterPauser(.json)
  replatform(10000 ether, 20000000000, "Replatform", "NGMI"){}
  


  
}
