const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Mints Treasury supply to owner(), increase treasury", async function () {
    const instance = await ERC20Treasury.deployed();
    let balance = await instance.balanceOf(accounts[0]);
    return assert.isTrue(balance.toNumber() == 10, "Did not mint to owner()");
    return assert.isTrue(instance.treasurySupply() = 10, "Did not increase Treasury");
  });
});
