// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ElipeCoin.sol";

contract ElipeCoinTest is Test {
    ElipeCoin t;

    address deployer = address(12345);

    function setUp() public {
        vm.startPrank(deployer);
        t = new ElipeCoin();
        vm.stopPrank();
    }

    function testName() public {
        assertEq(t.name(), "ElipeCoin");
    }

    function testSymbol() public {
        assertEq(t.symbol(), "ELC");
    }

    function testTokenSupply() public {
        assertEq(t.totalSupply(), 10000000e18);
    }

    function testTransfer() public {
        vm.startPrank(deployer);
        t.transfer(address(100), 5000e18);
        assertEq(t.balanceOf(address(100)), 5000e18);
    }

    function testApproveAndTransferFrom() public {
        vm.startPrank(deployer);
        t.approve(address(100), type(uint256).max);

        changePrank(address(100));
        t.transferFrom(deployer, address(200), 50000e18);

        assertEq(t.balanceOf(address(200)), 50000e18);
    }

    function testFailTransferThanSupply() public {
        vm.startPrank(deployer);
        vm.expectRevert(bytes("ERC20: transfer amount exceeds balance"));
        t.transfer(address(100), t.totalSupply() + 1);
    }
}
