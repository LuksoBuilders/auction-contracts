import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { ethers } from "hardhat";

const deployEasyContract = async function () {
  function sleep(ms: number) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  const easyAuctionAddress = "0xed6B3274Ec4D7CEc56d24D7584C0B16a3c592300";
  const wlyx = "0xBc92DA59222fC799822f92A4D37ccc9B9986187e";

  const DepositAndPlaceOrder = await ethers.getContractFactory(
    "DepositAndPlaceOrder",
  );
  const depositAndPlaceOrder = await DepositAndPlaceOrder.deploy(
    easyAuctionAddress,
    wlyx,
  );

  await sleep(5000);

  console.log(
    `depositAndPlaceOrder address is: `,
    depositAndPlaceOrder.address,
  );
};

deployEasyContract();

export default deployEasyContract;
