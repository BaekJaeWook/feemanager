pragma solidity 0.4.18;


interface FeeManagerInterface {

    function feeForMethod(bytes4 signature) public view returns (uint256);
    function collector() public view returns (address);

}
