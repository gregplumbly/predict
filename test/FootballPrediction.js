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

  it("Should set the manager as the contract deployer", async function () {
    expect(await footballPrediction.manager()).to.equal(owner.address);
  });
});
