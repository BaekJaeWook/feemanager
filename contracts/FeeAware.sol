pragma solidity 0.4.18;

import "./FeeManagerInterface.sol";

contract FeeAware {

    FeeManagerInterface public feeManager;

    modifier handleFee() {
        require(hasProvidedRequiredFee(msg.sig));

        moveFeeToVault(msg.sig);
        refundExcessFee(msg.sig);

        _;
    }

    function FeeAware(FeeManagerInterface _manager) public {
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
