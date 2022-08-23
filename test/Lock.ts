import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Lock", function () {
  async function deployOneYearLockFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    // Deploying version one 
    const VersionOne = await ethers.getContractFactory("VaultV1");
    const versionOne = await VersionOne.deploy();

    // Deploying the factory contract
    const Factory = await ethers.getContractFactory("Factory");
    const factory = await Factory.deploy(versionOne.address);

    // Creating a clone (using the factory contract)
    const Clone = await factory.create("Developeruche", 100, 1);
    await Clone.wait();

    // get the address of the clone
    const cloneAddress = await factory.getVault(1);
    const Clone_ = await ethers.getContractFactory("VaultV1");
    const clone = await Clone_.attach(cloneAddress);

    // deploying version two
    const VersionTwo = await ethers.getContractFactory("VaultV1");
    const versionTwo = await VersionTwo.deploy();

    // get the implementation address
    const beaconAddress = await factory.getBeacon();

    // running the upgrade
    const Beacon = await ethers.getContractFactory("VaultBeacon");
    const beacon = await Beacon.attach(beaconAddress);

    // upgrading
    const prev_addr = await factory.getImplementation();
    console.log("PREV", prev_addr);
    await beacon.update(versionTwo.address);
    const prev_addr2 = await factory.getImplementation();
    console.log("POST", prev_addr2);

    return { clone, factory, versionOne, owner, versionTwo, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set the right unlockTime", async function () {
      const { clone, factory } = await loadFixture(deployOneYearLockFixture);

      // expect(await lock.unlockTime()).to.equal(unlockTime);
    });
  });
});
