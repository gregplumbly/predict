const { expect } = require("chai");
const { ethers } = require("hardhat");

let owner;
let addr1;

describe("Football Prediction", () => {
  let FootballPrediction, footballPrediction;

  beforeEach(async () => {
    FootballPrediction = await ethers.getContractFactory("FootballPrediction");
    footballPrediction = await FootballPrediction.deploy();
    [owner, addr1] = await ethers.getSigners();
  });

  it("Should set the owner as the contract deployer", async function () {
    expect(await footballPrediction.owner()).to.equal(owner.address);
    expect((await footballPrediction.balanceOfPot()).toString()).to.equal("0");
  });

  it("the balance of the pot should be zero initially", async function () {
    expect((await footballPrediction.balanceOfPot()).toString()).to.equal("0");
  });
});
