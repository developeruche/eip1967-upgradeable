// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import "./VaultV1.sol";
import "./Beacon.sol";


contract Factory {
    mapping(uint256 => address) private vaults;

    VaultBeacon immutable beacon;

    constructor(address _vLogic) {
        beacon = new VaultBeacon(_vLogic);
    }

    event Cloned(address addr);

    function create(string calldata _name, uint256 _vaLue, uint256 x) external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(beacon), 
            abi.encodeWithSelector(VaultV1(address(0)).initialize.selector, _name, _vaLue)
        );
        vaults[x] = address(proxy);
        emit Cloned(address(proxy));
        return address(proxy);
    }

    function getImplementation() public view returns (address) {
        return beacon.implementation();
    }

     function getBeacon() public view returns (address) {
        return address(beacon);
    }

     function getVault(uint256 x) public view returns (address) {
        return vaults[x];
    }
}