const { expect } = require("chai");
const { Wallet } = require("ethers");
const { ethers } = require("hardhat");

require("@nomiclabs/hardhat-waffle");
import("contracts/BixosAirConditionings.sol");
describe("SetAirConditioning", function () {
  let contract;
  let owner;

  beforeEach(async function () {
    const SetAirConditioning = await ethers.getContractFactory("SetAirConditioning");
    const bixos = await SetAirConditioning.deploy("Life's Good");
    contract = await bixos.deployed();
    [owner] = await ethers.getSigners();
  });
  it("Trying 4 commands via 'setAdmin' function", async function () {
    var i;
    for(i = 0; i < 4; i++) {
        const test = expect(await contract.setAdmin(i, 100));
    }
  });
  it("Trying 4 commands via 'getAcDetail' function'", async function () {
        for(i = 0; i < 4; i++) {
        const test = expect(await contract.getAcDetail(i));
    }
  });
});
