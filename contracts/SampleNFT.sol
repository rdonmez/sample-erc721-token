// SPDX-License-Identifier: UNLISENSED

pragma solidity ^0.8.3;

import "./IERC721.sol";  
import "./Strings.sol";
import "./IERC721MetaData.sol";
import "./IERC721Enumarable.sol";
import "./Counters.sol";

contract SampleNFT is IERC721, ERC721Metadata, IERC721Enumarable {
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 private _totalSupply = 10000;
    string private _name;
    string private _symbol;

    mapping(uint256 => address) _owners;
    mapping(address => uint256) _balances;
    mapping(uint256 => address) _approvals;
    mapping(address => mapping(address=> bool)) _operatorApprovals;
    mapping(uint256 => string) private _tokenURIs;
    mapping(address => mapping(uint256 => uint256)) private _ownedTokens;
    mapping(uint256 => uint256) private _ownedTokensIndex;
    uint256[] private _allTokens;
    mapping(uint256 => uint256) private _allTokensIndex;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns(string memory) {
        return _name;
    }

    function symbol() public view virtual override returns(string memory) {
        return _symbol;
    }
  
    function balanceOf(address owner) public view virtual override returns(uint256) {
        return _balances[owner];
    }

    // Find the owner of NFT
    function ownerOf(uint256 tokenId) public view virtual override returns(address) {
        return _owners[tokenId];
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
 

    // Transfer ownership from one address to another address
    function saveTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual override  payable {
        this.transferFrom(from, to, tokenId);
    }

    function saveTransferFrom(address from, address to, uint256 tokenId) public virtual override  payable {
        this.transferFrom(from, to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override  payable {
        address owner = this.ownerOf(tokenId);
        
        require(from == owner, "You are not the owner");
        require(to != address(0), "transfer to the zero address");

        delete _approvals[tokenId];

        unchecked {
            _balances[from] -=1;
            _balances[to] +=1;
        }

        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    // Chand approved address for an NFT. approved is a new controller for the NFT.
    function approve(address approved, uint256 tokenId) public virtual override  payable {
        address owner = _owners[tokenId];
        require(owner == msg.sender, "You are not the owner");
        _approvals[tokenId] = approved;
        emit Approval(msg.sender, approved, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public virtual override  payable {
        require(msg.sender != operator, "ERC721: approve to caller");
        _operatorApprovals[msg.sender][operator];
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function getApproved(uint256 tokenId) public virtual override  view returns(address) {
        return _approvals[tokenId];
    }

    function isApprovedForAll(address owner, address operator) public virtual override  view returns(bool) {
        return _operatorApprovals[owner][operator];
    } 

    function mint(address to, string memory uri) internal {

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        
        require(to != address(0), "Zero address");
        require(!(_owners[tokenId] != address(0)), "already minted");

        unchecked {
            _balances[to] += 1;
        }

        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

        _setTokenURI(tokenId, uri);
    }

    function burn(uint256 tokenId) internal {

        address owner = this.ownerOf(tokenId);

        require(owner != address(0), "There is no owner");

        delete _approvals[tokenId];

        unchecked {
            _balances[owner] -= 1;
        }

        delete _owners[tokenId];
        delete _tokenURIs[tokenId];

        emit Transfer(owner, address(0), tokenId);
    }
 
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        
        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();
 
        if (bytes(base).length == 0) {
            return _tokenURI;
        } 
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }
 
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(_owners[tokenId] != address(0), "uri of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }
 
    function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256) {
        return _ownedTokens[owner][index];
    }
 
    function totalSupply() public view virtual override returns (uint256) {
        return _allTokens.length;
    }
 
    function tokenByIndex(uint256 index) public view virtual override returns (uint256) {
        return _allTokens[index];
    }
}