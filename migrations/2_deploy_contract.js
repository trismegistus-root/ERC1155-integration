const Replatform = artifacts.require("./Replatform.sol")
module.exports = function (deployer) {
  deployer.deploy(Replatform, "Replatform", "NGMI", 2000, 10);
};
