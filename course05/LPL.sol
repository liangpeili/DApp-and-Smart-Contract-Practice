// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC721.sol";

contract LPL is ERC721 {
    uint public MAX_LPLS = 100; // 总量

    // 构造函数
    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://voidtech.cn/i/2022/11/20/nwjv7t.jpeg";
    }

    // 铸造函数
    function mint(address to, uint tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_LPLS, "tokenId out of range");
        _mint(to, tokenId);
    }
}
