const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Increases treasury supply from initial minting", async function () {
    const instance = await ERC20Treasury.deployed();
    let treasury = await instance.totalTreasury();
    return assert.isTrue(treasury.toNumber() == 10, "Did not increase treasury supply");
  });
});
