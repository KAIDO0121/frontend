// ERC721
// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract IDONTKNOW is ERC721 {
    uint256 public saleStartTime;
    uint256 public totalSupply;
    uint256 public mintPrice = 100;
    uint256 public maxSupply = 30;

    constructor(uint256 _saleStartTime, uint256 _totalSupply)
        ERC721("MYNFT", "BANG")
    {
        saleStartTime = _saleStartTime;
        totalSupply = _totalSupply;
    }

    function mint(uint256 tokenId, uint256 _mintPrice) public {
        require(_mintPrice >= mintPrice, "Invalid mint price");
        require(
            block.timestamp < saleStartTime,
            "The auction not starting yet"
        );
        require(totalSupply <= maxSupply, "Insufficient supply");
        _mint(msg.sender, tokenId);
        totalSupply += 1;
    }

    function getAvailableSupply() public view returns (uint256) {
        return maxSupply - totalSupply;
    }

    function t123() public view returns (uint256) {
        return maxSupply;
    }
}
