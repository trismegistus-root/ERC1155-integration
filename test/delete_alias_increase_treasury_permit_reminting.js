const deleteAliasIncreaseTreasuryPermitReminting = artifacts.require("deleteAliasIncreaseTreasuryPermitReminting");


contract("deleteAliasIncreaseTreasuryPermitReminting", function (/* accounts */) {
  it("should assert true", async function () {
    await deleteAliasIncreaseTreasuryPermitReminting.deployed();
    return assert.isTrue(true);
  });
});
