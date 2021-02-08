const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Increases treasury wallet supply from initial minting", async function () {
    const instance = await ERC20Treasury.deployed(); //deploys contract, mints 10 to Owner(), wallet = 10
    let balance = await instance.balanceOf(accounts[0]);
    return assert.isTrue(balance.toNumber() == 10, "Did not mint to treasury wallet");
  });
});
