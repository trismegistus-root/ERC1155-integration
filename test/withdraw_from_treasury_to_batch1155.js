const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Withdraw from Owner() wallet to 1155 batch, reduce treasury", async function () {
    const instance = await ERC20Treasury.deployed(); //deploys contract, mints 10 to Owner(), wallet = 10
    await instance.withdrawFromTreasury(accounts[1], 10); //withdraw
    let balance_1 = await instance.balanceOf(accounts[0]); //should be 0
    let balance_2 = await instance.balanceOf(accounts[1]); //should be 10
    return assert.isTrue(balance_1.toNumber() == 0, "Did not decrease treasury wallet");
    return assert.isTrue(instance.treasurySupply() = 0, "Did not decrease Treasury");
    return assert.isTrue(balance_2.toNumber() == 10, "Did not withdraw to batch1155");

  });
});
