/// SPDX-Lisence-Identifier: UNLICENSED

pragma solidity ^0.8.3;

interface IERC721 {
    
    event Transfer (address indexed from, address indexed to, uint256 tokenId);

    event Approval (address indexed owner, address indexed approved, uint256 tokenId);

    event ApprovalForAll (address indexed owner, address indexed operator, bool approved);

    /// Count of all NFTs that assigned to the owner
    function balanceOf(address owner) external view returns(uint256);

    // Find the owner of NFT
    function ownerOf(uint256 tokenId) external view returns(address);

    // Transfer ownership from one address to another address
    function saveTransferFrom(address from, address to, uint256 tokenId, bytes memory data) external payable;

    function saveTransferFrom(address from, address to, uint256 tokenId) external payable;

    function transferFrom(address from, address to, uint256 tokenId) external payable;

    // Chand approved address for an NFT. approved is a new controller for the NFT.
    function approve(address approved, uint256 tokenId) external payable;

    function setApprovalForAll(address operator, bool approved) external payable;

    function getApproved(uint256 tokenId) external view returns(address);

    function isApprovedForAll(address owner, address operator) external view returns(bool); 
}