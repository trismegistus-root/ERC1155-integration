const ERC20Treasury = artifacts.require("./ERC20Treasury.sol")
module.exports = function (deployer) {
  deployer.deploy(ERC20Treasury, "Replatform", "NGMI", 2000*10**18, 100000);
 
};
