const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Treasury wallet supply increases upon batch deposit to treasury", async function () {
    const instance = await ERC20Treasury.deployed(); 
    await instance.withdrawFromTreasury(accounts[1], 10);
    await instance.depositToTreasury(accounts[1], 10)
    let balance = await instance.balanceOf(accounts[0]);
    return assert.isTrue(balance.toNumber() == 10, "Batch deposit did not transfer to Treasury wallet");
  });
});

