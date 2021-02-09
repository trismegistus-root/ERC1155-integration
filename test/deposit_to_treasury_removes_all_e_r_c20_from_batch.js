const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Deposit from batch decreases batch supply", async function () {
    const instance = await ERC20Treasury.deployed(); 
    await instance.withdrawFromTreasury(accounts[1], 10);
    await instance.depositToTreasury(accounts[1], 10);
    let balance = await instance.balanceOf(accounts[1]);
    return assert.isTrue(balance.toNumber() == 0, "Deposit from batch did not decrease batch supply");
  });
});
