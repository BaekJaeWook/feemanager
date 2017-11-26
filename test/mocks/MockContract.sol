pragma solidity 0.4.18;

import "./../../contracts/FeeAware.sol";

contract MockContract is FeeAware {

    function MockContract(FeeManagerInterface manager) FeeAware(manager) public {}

    function() payable public handleFee {

    }
}
