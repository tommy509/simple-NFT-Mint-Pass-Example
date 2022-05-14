async function main() {
    const Main = await ethers.getContractFactory("SimpleMintPass");
    const main   = await Main.deploy()
    console.log("Contract deployed to address :", main.address)
  }
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
  