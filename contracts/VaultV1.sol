// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";



// This is what is would say is the base contract ans this is the contract that would be upgraded (This contract should be considered as the Logic contract)
contract VaultV1 is Initializable {
    // This is the state variable  section (The order really matters)
    string public name;
    uint256 public vaLue;

    error Down(string reason);

    // This is the rep of the constructor 
    function initialize(string memory _name, uint256 _vaLue) public initializer {
        name = _name;
        vaLue = _vaLue;
    }

    // This is the only function, that would be constant 
    function down() public {
        if (vaLue == 0) revert Down("!vaLue");
        vaLue--;
    }
}