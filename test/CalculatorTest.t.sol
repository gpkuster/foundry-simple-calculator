// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "../src/Calculator.sol";
import "forge-std/Test.sol";

contract CalculatorTest is Test {

    Calculator calculator;
    uint256 public initialValue = 0;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        // vm.addr() impersonal address
        calculator = new Calculator(initialValue, admin);
    }

    // Unit testing
    function testCheckFirstResultado() public view {
        assert(initialValue == calculator.result());
    }

    function testAddition() public {
        assert(10 == calculator.addition(5, 5));
    }

    function testSubstraction() public {
        assert(0 == calculator.substraction(5, 5));
    }

    function testDivision() public {
        assert(2 == calculator.division(10, 5));
    }

    function testMultiplier() public {
        assert(50 == calculator.multiplication(10, 5));
    }

    function testCannotMultiplyTwoLargeNumbers() public {
        vm.expectRevert();
        calculator.multiplication(3456789098654323456789009876543459654345678900987654345678900987654678900, 1098765456780);
    }

    function testDivisionRevertsOnZeroDivisor() public {
        vm.expectRevert(bytes("Cannot divide by zero"));
        calculator.division(10, 0);
    }

    function testShouldRevertWhenIsNotAdmin() public {
        // Everything executed after this will be done from random user address
        // Note that foundry has its default address - this test would pass still without the startPrank(...) part
        vm.startPrank(randomUser);
        vm.expectRevert();
        calculator.setResult(0);
        vm.stopPrank();
    }

    function testOnlyAdminCanChangeResult() public {
        vm.startPrank(admin);
        calculator.setResult(0);
        assert(initialValue == calculator.result());
        vm.stopPrank();
    }
}