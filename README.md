# OZ Token Demo

An ERC-20 token built on OpenZeppelin Contracts v5, with role-based access control, pausing and EIP-2612 permits. Built with Foundry, tested, and deployed + verified on Sepolia.

**Live contract (Sepolia):** [0xABA33DAd4FA34A83eb61aCb898dD146b433f5319](https://sepolia.etherscan.io/address/0xABA33DAd4FA34A83eb61aCb898dD146b433f5319#code)

## Design

| Feature | OpenZeppelin module | Why |
|---|---|---|
| Token standard | `ERC20` | Standard fungible token |
| Minting | `AccessControl` + `MINTER_ROLE` | Only approved addresses can mint |
| Pausing | `ERC20Pausable` + `PAUSER_ROLE` | Emergency stop for all transfers |
| Gasless approvals | `ERC20Permit` (EIP-2612) | Approvals via signature, no separate tx |

Roles are split (admin, pauser, minter) instead of a single `Ownable` owner, so in production each could sit with a different key or multisig.

## Tests

```bash
forge test -vv
```

- Admin with `MINTER_ROLE` can mint
- Non-minters are reverted
- Transfers revert while paused

## Run it yourself

```bash
git clone https://github.com/Gabbrriell/oz-token-demo
cd oz-token-demo
forge install
forge build
forge test
```

## Deploy

```bash
forge create src/MyToken.sol:MyToken \
  --rpc-url $SEPOLIA_RPC --private-key $PK --broadcast \
  --verify --etherscan-api-key $ETHERSCAN_KEY \
  --constructor-args <admin> <pauser> <minter>
```