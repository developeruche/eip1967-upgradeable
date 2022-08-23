// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract Vaultv2 is Initializable {
    // Notice that the states variable order is not distructed
    string public name;
    uint256 public vaLue;
    
    error Down(string reason);

    // This again acting as sthe constructor
    function initialize(string memory _name, uint256 _vaLue) public initializer {
        name = _name;
        vaLue = _vaLue;
    }

    // present in the perivous version
    function down() public {
        if (vaLue == 0) revert Down("!vaLue");
        vaLue--;
    }
    // This is the new update
    function up() public {
        vaLue++;
    }

}