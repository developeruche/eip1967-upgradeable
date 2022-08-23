// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract VaultBeacon {

    UpgradeableBeacon immutable beacon;
    
    address public vLogic;
    address proxyAdmin;

    constructor(address _vLogic) {
        beacon = new UpgradeableBeacon(_vLogic);
        vLogic = _vLogic;
        proxyAdmin = tx.origin;
    }

    modifier OnlyAdmin {
        require(msg.sender == proxyAdmin, "Not Admin");
        _;
    }

    function update(address _vLogic) public OnlyAdmin {
        beacon.upgradeTo(_vLogic);
        vLogic = _vLogic;
    }

    function implementation() public view returns(address) {
        return beacon.implementation();
    }
}