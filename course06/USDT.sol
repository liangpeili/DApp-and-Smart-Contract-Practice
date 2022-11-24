// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./tokens/ERC20.sol";

contract USDT is ERC20 {
    constructor() ERC20("USDT", "USDT", 18) {
        _mint(msg.sender, 1 * 10**8 * 10**18);
    }
}
