// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;
    address admin = address(1);
    address user = address(2);

    function setUp() public {
        token = new MyToken(admin, admin, admin);
    }

    function test_AdminCanMint() public {
        vm.prank(admin);
        token.mint(user, 100);
        assertEq(token.balanceOf(user), 100);
    }

    function test_RevertWhen_NonMinterMints() public {
        vm.prank(user);
        vm.expectRevert();
        token.mint(user, 100);
    }

    function test_PauseBlocksTransfers() public {
        vm.prank(admin);
        token.mint(user, 100);
        vm.prank(admin);
        token.pause();
        vm.prank(user);
        vm.expectRevert();
        token.transfer(admin, 10);
    }
}
