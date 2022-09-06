// SPDX-License-Identifier: UNLISENSED

pragma solidity ^0.8.3;

interface ERC721TokenReceiver {
    
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external returns(bytes4);
}