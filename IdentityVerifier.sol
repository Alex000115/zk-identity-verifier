// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IVerifier.sol";

contract IdentityVerifier {
    IVerifier public snarkVerifier;
    mapping(uint256 => bool) public usedNullifiers;
    
    event IdentityVerified(address indexed user, uint256 nullifier);

    constructor(address _verifierAddress) {
        snarkVerifier = IVerifier(_verifierAddress);
    }

    /**
     * @dev Verifies a ZK proof of identity.
     * @param a Proof point A
     * @param b Proof point B
     * @param c Proof point C
     * @param input Public inputs (including the nullifier)
     */
    function verifyIdentity(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[1] memory input
    ) public {
        uint256 nullifier = input[0];
        require(!usedNullifiers[nullifier], "Identity already used");
        
        // Verify the proof via the generated Snark Verifier
        require(snarkVerifier.verifyProof(a, b, c, input), "Invalid ZK Proof");

        usedNullifiers[nullifier] = true;
        emit IdentityVerified(msg.sender, nullifier);
    }
}
