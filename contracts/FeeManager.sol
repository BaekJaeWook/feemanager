pragma solidity 0.4.18;

import "./Ownership/Ownable.sol";
import "./FeeManagerInterface.sol";

contract FeeManager is FeeManagerInterface, Ownable {

    address public collector;

    mapping (bytes4 => uint256) public fees;

    function FeeManager(address _collector) public {
        collector = _collector;
    }

    function setFeeForMethod(bytes4 signature, uint256 fee) public onlyOwner {
        fees[signature] = fee;
    }

    function feeForMethod(bytes4 signature) public view returns (uint256) {
        return fees[signature];
    }

    function collector() public view returns (address) {
        return collector;
    }
}
