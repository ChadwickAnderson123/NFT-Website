// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./SimpleFallBack.sol";

contract DCWeedToken is ERC721, ERC721Enumerable, ERC721URIStorage, SimpleFallBack {
    address owner;

    constructor() ERC721("DCWeedToken", "DCW") {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender, 'You do not have permission to execute this functionality');
        _;
    }

    struct ArtToken {
    string name;
    string artist;
    uint256 tokenPrice;
    }

    mapping(uint256 => ArtToken) public artCollection;

    event setPrice(uint256 token_id, uint256 tokenPrice, string reportURI);

    function mint(
        address _owner, 
        uint256 tokenPrice, 
        string memory name, 
        string memory artist, 
        string memory _tokenURI
        ) public returns(uint256) {
        
        // call totalSupply function, set it equal to tokenId
        uint256 tokenId = totalSupply();

        // call _mint and _setTokenURI functions
        _mint(_owner, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        // set in artCollection mapping
        artCollection[tokenId] = ArtToken(name, artist, tokenPrice);

        return tokenId;
    }

    function newPrice(
        uint256 tokenId,
        uint256 _newTokenPrice,
        string memory reportURI
    ) public onlyOwner returns(uint256) {
        // set _newPrice equal to the token's price
        artCollection[tokenId].tokenPrice = _newTokenPrice;

        // emit setPrice event
        emit setPrice(tokenId, _newTokenPrice, reportURI);

        // return the new price
        return artCollection[tokenId].tokenPrice;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable)
        returns (bool) {
            return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) 
        internal 
        virtual 
        override(ERC721, ERC721URIStorage) {
            super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721, ERC721URIStorage) 
        returns(string memory) {
            return super.tokenURI(tokenId);
    }

}