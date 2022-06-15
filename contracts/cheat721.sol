// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract SEANNFT is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    uint256 public saleStartTime;
    uint256 public mintPrice = 1000000000000000000; // 1ETH
    uint256 public maxSupply = 1;

    Counters.Counter private _tokenIdCounter;

    constructor(uint256 _saleStartTime) ERC721("SEANNFT", "SNFT") {
        saleStartTime = _saleStartTime;
    }

    function mint() public payable {
        uint256 tokenId = _tokenIdCounter.current();
        require(msg.value >= mintPrice, "Invalid mint price");
        require(
            block.timestamp < saleStartTime,
            "The auction not starting yet"
        );
        require(tokenId + 1 <= maxSupply, "Insufficient supply");

        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function balanceOfMine() public view returns (uint256) {
        require(
            msg.sender != address(0),
            "ERC721: address zero is not a valid owner"
        );
        return super.balanceOf(msg.sender);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function getAvailableSupply() public view returns (uint256) {
        return maxSupply - _tokenIdCounter.current();
    }
}
