// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract POAP is ERC721URIStorage {
    uint256 private _tokenIdCounter;
    mapping(address => bool) private _hasClaimed;

    event POAPMinted(address indexed attendee, uint256 tokenId);

    constructor() ERC721("POAP Token", "POAP") {}

    function claimPOAP(string memory tokenURI) external {
        require(!_hasClaimed[msg.sender], "POAP already claimed");

        uint256 tokenId = _tokenIdCounter++;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _hasClaimed[msg.sender] = true;

        emit POAPMinted(msg.sender, tokenId);
    }

    function hasClaimed(address attendee) external view returns (bool) {
        return _hasClaimed[attendee];
    }
}
