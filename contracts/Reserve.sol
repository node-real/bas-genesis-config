// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import "./Injector.sol";

contract Reserve is IReserve, InjectorContextHolder {

    event Released(address indexed addr, uint256 amount);

    constructor(bytes memory constructorParams) InjectorContextHolder(constructorParams) {
    }

    function ctor() external whenNotInitialized {
    }

    function release(address addr, uint256 amount) external onlyFromReward {
        payable(address(addr)).transfer(amount);
        emit Released(addr, amount);
    }
}