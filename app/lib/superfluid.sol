pragma solidity ^0.8.0;

import "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";
import "@superfluid-finance/ethereum-contracts/contracts/interfaces/tokens/IERC20WithTokenInfo.sol";

contract MoneyStream {
    ISuperfluid private _host;
    IConstantFlowAgreementV1 private _cfa;
    IERC20WithTokenInfo private _token;
    address private _sender;
    address private _receiver;
    uint256 private _flowRate;

    constructor(
        address host,
        address cfa,
        address token,
        address sender,
        address receiver
    ) {
        _host = ISuperfluid(host);
        _cfa = IConstantFlowAgreementV1(cfa);
        _token = IERC20WithTokenInfo(token);
        _sender = sender;
        _receiver = receiver;
    }

    function startStream(uint256 flowRate) external {
        _flowRate = flowRate;
        _token.approve(address(_cfa), flowRate);
        _cfa.createFlow(_token, _receiver, flowRate, new bytes(0));
    }

    function updateStream(uint256 newFlowRate) external {
    _cfa.updateFlow(_token, _receiver, newFlowRate, new bytes(0));
    _flowRate = newFlowRate;
}

    function stopStream() external {
        _cfa.deleteFlow(_token, _sender, _receiver, new bytes(0));
    }

    function sendLumpSum(uint256 amount) external {
        _token.transferFrom(_sender, address(this), amount);
        _token.transfer(_receiver, amount);
    }
}