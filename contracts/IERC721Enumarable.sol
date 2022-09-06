// SPDX-License-Identifier: UNLISENSED

pragma solidity ^0.8.3;

interface IERC721Enumarable {

    function totalSupply() external view returns(uint256);

    function tokenByIndex(uint256 index) external view returns(uint256);

    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
}