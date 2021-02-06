const replatform = artifacts.require("replatform");
const ERC20Treaury = artifacts.require("ERC20Treasury")


module.exports = function (deployer) {
  deployer.deploy(replatform);
  deployer.deploy(ERC20Treaury);
 
};
