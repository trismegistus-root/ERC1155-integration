const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Withdraws from treasury to batched 1155", async function () {
    const instance = await ERC20Treasury.deployed(); //deploys contract, mints 10 to Owner(), wallet = 10
    await instance.withdrawFromTreasury(accounts[1], 10);
    let balance = await instance.balanceOf(accounts[1]);
    return assert.isTrue(balance.toNumber() == 10, "Did not complete withdrawal from treasury to batched 1155");
  });
});
