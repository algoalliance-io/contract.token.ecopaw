// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/EcoPawToken.sol";

contract EcoPawTokenTest is Test {
    EcoPaw t;

    address deployer = address(12345);

    function setUp() public {
        vm.startPrank(deployer);
        t = new EcoPaw();
        vm.stopPrank();
    }

    function testName() public {
        assertEq(t.name(), "Eco Paw");
    }

    function testTokenSupply() public {
        assertEq(t.totalSupply(), 210_000_000_000e18);
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
