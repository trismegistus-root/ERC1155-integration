const replatform = artifacts.require("replatform");
const replatformPartitioner = artifacts.require("replatformPartitioner")

module.exports = function (deployer) {
  deployer.deploy(replatform);
  deployer.deploy(replatformPartitioner);
};
