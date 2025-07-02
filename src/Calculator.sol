// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Calculator {

    uint256 public result;
    address public admin;

    event Addition(uint256 num1, uint256 num2, uint256 result);
    event Substraction(uint256 num1, uint256 num2, uint256 result);
    event Division(uint256 num1, uint256 num2, uint256 result);
    event Multiplication(uint256 num1, uint256 num2, uint256 result);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    /// @notice Initializes the calculator with an initial result value
    /// @param initialValue The starting value for the result
    constructor(uint256 initialValue, address _admin) {
        result = initialValue;
        admin = _admin;
    }

    /// @notice Adds two numbers, stores the result in state, and returns it
    /// @param num1 First operand
    /// @param num2 Second operand
    /// @return The sum of num1 and num2
    function addition(uint256 num1, uint256 num2) external returns (uint256) {
        result = num1 + num2;
        emit Addition(num1, num2, result);
        return result;
    }

    /// @notice Subtracts the second number from the first, stores the result in state, and returns it
    /// @param num1 Minuend (the number to subtract from)
    /// @param num2 Subtrahend (the number to subtract)
    /// @return The result of num1 - num2
    function substraction(uint256 num1, uint256 num2) external returns (uint256) {
        result = num1 - num2;
        emit Substraction(num1, num2, result);
        return result;
    }

    /// @notice Divides the first number by the second, stores the result in state, and returns it
    /// @dev Reverts on division by zero
    /// @param num1 Dividend (the number to be divided)
    /// @param num2 Divisor (the number to divide by)
    /// @return The result of num1 / num2
    function division(uint256 num1, uint256 num2) external returns (uint256) {
        require(num2 != 0, "Cannot divide by zero");
        result = num1 / num2;
        emit Division(num1, num2, result);
        return result;
    }

    /// @notice Multiplies two numbers, stores the result in state, and returns it
    /// @param num1 First operand
    /// @param num2 Second operand
    /// @return The product of num1 and num2
    function multiplication(uint256 num1, uint256 num2) external returns (uint256) {
        result = num1 * num2;
        emit Multiplication(num1, num2, result);
        return result;
    }

    /// @notice Allows admin to reset the result value
    /// @param _result The value to set     
    function setResult(uint256 _result) external onlyAdmin() {
        result = _result;
    }

}
