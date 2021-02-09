const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Deposit from batch increases treasury total supply", async function () {
    const instance = await ERC20Treasury.deployed(); //bookmark
    await instance.withdrawFromTreasury(accounts[1], 10);
    await instance.depositToTreasury(accounts[1], 10);
    let balance = await instance.totalTreasury()
    return assert.isTrue(balance.toNumber() == 10, "Deposit from batch did not increae treasury supply");
  });
});
