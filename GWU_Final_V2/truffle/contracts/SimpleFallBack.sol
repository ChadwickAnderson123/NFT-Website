// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleFallBack {
    uint public lastValueSent;
    string public lastFunctionCalled;

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }
}