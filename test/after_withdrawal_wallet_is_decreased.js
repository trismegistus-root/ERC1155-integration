const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Treasury wallet decreases after withdrawal from Treasury", async function () {
    const instance = await ERC20Treasury.deployed(); 
    await instance.withdrawFromTreasury(accounts[1], 10);
    let balance = await instance.balanceOf(accounts[0]);
    return assert.isTrue(balance.toNumber() == 0, "Did not complete withdrawal from treasury to batched 1155");
  });
});
