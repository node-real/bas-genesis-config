// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import "./Injector.sol";

contract Reward is IReward, InjectorContextHolder {

    address constant deadAddress= 0x000000000000000000000000000000000000dEaD;
    address owner;

    event UpdateOwner(address indexed owner);

    event Burned(uint256 amount);
    event BurnedAndReserveReleased(uint256 amount, address indexed to, uint256 releaseAmount);

    event Claim(address indexed to, uint256 amount);
    event ClaimAndBurned(address indexed to, uint256 amount, uint256 burnedAmount);

    constructor(bytes memory constructorParams) InjectorContextHolder(constructorParams) {
    }

    function ctor(address _owner) external whenNotInitialized {
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function updateOwner(address _owner) external onlyOwner {
        owner = _owner;
        emit UpdateOwner(_owner);
    }

    function burn(uint256 amount) external onlyOwner {
        payable(deadAddress).transfer(amount);
        emit Burned(amount);
    }

    function burnAndReserveRelease(uint256 amount,address to, uint256 releaseAmount) external onlyOwner {
        payable(deadAddress).transfer(amount);
        _reserveContract.release(to, releaseAmount);
        emit BurnedAndReserveReleased(amount, to, releaseAmount);
    }

    function claim(address to, uint256 amount) external onlyOwner {
        payable(to).transfer(amount);
        emit Claim(to, amount);
    }

    function claimAndBurn(address to, uint256 amount, uint256 burnedAmount) external onlyOwner {
        payable(to).transfer(amount);
        payable(deadAddress).transfer(burnedAmount);
        emit ClaimAndBurned(to, amount, burnedAmount);
    }

    receive() external payable {
    }
}