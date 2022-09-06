// SPDX-License-Identifier: UNLISENSED

pragma solidity ^0.8.3;
  
interface ERC721Metadata  {
    
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function tokenURI(uint256 _tokenId) external view returns (string memory);
}