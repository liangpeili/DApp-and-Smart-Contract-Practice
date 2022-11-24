// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./tokens/ERC721.sol";

contract CBI is ERC721 {
    uint public MAX_CBIS = 100; // 总量

    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://voidtech.cn/i/2022/11/20/nwjv7t.jpeg";
    }

    function mint(address to, uint tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_CBIS, "tokenId out of range");
        _mint(to, tokenId);
    }
}
