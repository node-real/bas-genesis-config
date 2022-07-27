// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import "../ChainConfig.sol";

contract FakeChainConfig is ChainConfig {

    constructor(
        IStaking stakingContract,
        ISlashingIndicator slashingIndicatorContract,
        ISystemReward systemRewardContract,
        IStakingPool stakingPoolContract,
        IGovernance governanceContract,
        IChainConfig chainConfigContract,
        IRuntimeUpgrade runtimeUpgradeContract,
        IDeployerProxy deployerProxyContract
    ) ChainConfig(
        stakingContract,
        slashingIndicatorContract,
        systemRewardContract,
        stakingPoolContract,
        governanceContract,
        chainConfigContract,
        runtimeUpgradeContract,
        deployerProxyContract
    ) {
    }

    modifier onlyFromCoinbase() override {
        _;
    }

    modifier onlyFromSlashingIndicator() override {
        _;
    }

    modifier onlyFromGovernance() override {
        _;
    }

    modifier onlyBlock(uint64 /*blockNumber*/) override {
        _;
    }

    function setFreeGasAddressAdmin(address freeGasAddressAdminAddress) public override {
        _setFreeGasAddressAdmin(freeGasAddressAdminAddress);
    }

    function setFreeGasAddressSize(uint32 newFreeGasAddressSize) public override {
        _setFreeGasAddressSize(newFreeGasAddressSize);
    }

    function addFreeGasAddress(address freeGasAddress) public override {
        _addFreeGasAddress(freeGasAddress);
    }

    function removeFreeGasAddress(address freeGasAddress) public override {
        _removeFreeGasAddress(freeGasAddress);
    }
}