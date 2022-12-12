const fs = require('fs');
const ethers = require('ethers');

const bytecode = fs.readFileSync('./bytecode', 'utf-8');
const abi = JSON.parse(fs.readFileSync('./ERC20.json'));

const provider = new ethers.providers.JsonRpcProvider("https://exchaintestrpc.okex.org");
const wallet = new ethers.Wallet("c2a8b12e9bb1fff09b296e0eceb7cd6e5929b7e06c4e7c887d67905dbd52a184");
const signer = wallet.connect(provider);

const main = async () => {
  const factory = new ethers.ContractFactory(abi, bytecode, signer)
  const contract = await factory.deploy();
  console.log('address', contract.address)

  const accounts = JSON.parse(fs.readFileSync('./accounts.json'));
  const amount = "201000000000000000000";

  for (let account of accounts) {
    const tx = await contract.transfer(account.address, amount);
    await tx.wait();
    console.log(account.address, tx.hash);
  }
}


main()