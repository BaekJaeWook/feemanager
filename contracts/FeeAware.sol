pragma solidity 0.4.18;

import "./FeeManagerInterface.sol";

contract FeeAware {

    FeeManagerInterface public feeManager;

    modifier handleFee(bytes4 signature) {
        require(hasProvidedRequiredFee(signature));

        moveFeeToVault(signature);
        refundExcessFee(signature);

        _;
    }

    function FeeAware(FeeManagerInterface _manager) {
        feeManager = _manager;
    }

    function moveFeeToVault(bytes4 signature) internal {
        feeManager.collector().transfer(feeManager.feeForMethod(signature));
    }

    function refundExcessFee(bytes4 signature) internal {
        uint256 fee = feeManager.feeForMethod(signature);
        if (msg.value > fee) {
            msg.sender.transfer(msg.value - fee);
        }
    }

    function hasProvidedRequiredFee(bytes4 signature) internal view returns (bool) {
        return msg.value >= feeManager.feeForMethod(signature);
    }
}
