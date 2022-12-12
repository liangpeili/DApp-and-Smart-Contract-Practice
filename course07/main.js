const ethers = require('ethers');
const fs = require('fs');

// 查询ethers 官方文档，查询如何配置一个alchemy的provider
const apiKey = "r0psWB88gF4sgJAxbzQcJqPMDwl8f3XQ"
const provider = new ethers.providers.AlchemyProvider("homestead", apiKey);

// 生成合约实例
const address = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
const abi = JSON.parse(fs.readFileSync('./ERC20.json'));
const contract = new ethers.Contract(address, abi, provider);

async function main() { 

  // 获取链基本信息
  // const network = await provider.getNetwork();
  const blockNumber = await provider.getBlockNumber();
  const gasPrice = await provider.getGasPrice();
  const block = await provider.getBlock(blockNumber);
  // console.log(network);
  console.log('block number', blockNumber);
  console.log('gas price', gasPrice.toString());
  console.log('block miner', block.miner);

  // 获取USDT合约基本信息
  const decimals = await contract.decimals();
  const totalSupply = await contract.totalSupply();
  const symbol = await contract.symbol();
  console.log('decimals', decimals);
  console.log('total supply', totalSupply.toString());
  console.log('symbol', symbol);

  // 获取从最新高度往前的100个区块里的Transfer事件
  const events = await contract.queryFilter('Transfer', blockNumber - 100, blockNumber);
  console.log('event length', events);
}

main();