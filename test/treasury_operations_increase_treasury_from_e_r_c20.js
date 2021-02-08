const ERC20Treasury = artifacts.require("./ERC20Treasury.sol");

contract("ERC20Treasury", accounts => {
  it("Increases treasury by 10 from ERC20, mints to Owner()", async function () {
    const instance = await ERC20Treasury.deployed();
    await instance._increaseTreasuryFromSupply(10);
    let balance = await instance.balanceOf(accounts[0]);
    return assert.isTrue(balance.toNumber() == 20, "Did not mint to owner()");
    return assert.isTrue(instance.treasurySupply() = 20, "Did not increase Treasury");
  });
});
