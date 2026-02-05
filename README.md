# ZK Identity Verifier

This repository contains a high-quality, flat-structured implementation of a Zero-Knowledge proof system for identity. It allows a user to prove they satisfy a specific criteria (e.g., "I am over 18 years old") to a Smart Contract without ever revealing their actual birthdate or identity document.

## Features
- **Privacy-Preserving**: Proofs are generated locally; only the proof and a public nullifier are sent on-chain.
- **Circuit Logic**: Includes Circom circuits for range proofs and Merkle tree membership.
- **On-Chain Verification**: Solidity verifier contract generated for gas-efficient proof validation.
- **Anti-Double-Claim**: Uses nullifiers to prevent the same identity from being used multiple times for the same action.

## Technical Overview
The system uses the Groth16 proof system. A prover demonstrates knowledge of a private input $x$ (e.g., birth year) such that it satisfies a public constraint (e.g., $2026 - x \geq 18$):

$$\pi = \text{Setup}(Circuit, \text{PrivateInputs}, \text{PublicInputs})$$

The Smart Contract then runs the `verifyProof` function:
$$V(\pi, \text{PublicInputs}) \rightarrow \{0, 1\}$$



## License
MIT
