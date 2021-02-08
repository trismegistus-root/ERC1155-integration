const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Treasury supply decreases after withdrawal from Treasury", async function () {
    const instance = await ERC20Treasury.deployed(); 
    await instance.withdrawFromTreasury(accounts[1], 10);
    let treasury = await instance.totalTreasury();
    return assert.isTrue(treasury.toNumber() == 0, "Did not complete withdrawal from treasury to batched 1155");
  });
});
