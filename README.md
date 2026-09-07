# Bitcoin Core for YunoHost

[![Integration level](https://dash.yunohost.org/integration/bitcoin_core.svg)](https://dash.yunohost.org/appci/app/bitcoin_core)

Headless Bitcoin Core packaging for YunoHost. The package provides `bitcoind`
as a shared local service for applications such as Core Lightning, BTCPay and
explorers; it does not provide a web UI or require a domain.

## Initial design

- Bitcoin Core 31.1 official Linux binaries for amd64 and arm64.
- Mainnet by default, with pruned 25 GB storage by default.
- Wallet disabled by default (`disablewallet=1`).
- RPC bound to `127.0.0.1:8332`; P2P uses the allocated port (8333 by default).
- A dedicated `core_lightning` RPC credential is generated and stored in
  `/etc/bitcoin_core/core-lightning.rpc`; Bitcoin Core does not provide
  method-level RPC ACLs, so this is service-scoped authentication rather than
  fine-grained authorization.
- Blockchain data is kept in YunoHost's `data_dir`, separate from binaries.
- Installation starts initial block download and does not wait for completion.
- Synchronization can be deferred at install time and started later from the
  YunoHost Config Panel.
- Backups include configuration and wallet data only, never blocks or chainstate.

This is an initial package scaffold. Richer diagnostics, regtest CI and
Nostr Catalog publication are follow-up work.

## Nostr Catalog readiness

The repository includes the catalog's reusable static-security workflow. It
must be run from the eventual public package repository, because catalog
declarations bind the app to the exact Git repository, commit, manifest hash
and repository-tree hash. The catalog publisher accepts a repository URL and
Git ref through the `nostr_catalog` app's Publisher configuration panel.

Before publishing, the package still needs:

- a public Git repository and stable release ref;
- a package logo suitable for the YunoHost catalogue;
- a successful static-security run, including manifest validation and
  `package_linter`/ShellCheck checks;
- a separate protected attestation workflow if the catalogue is configured to
  require CI attestations. The verifier key must never be committed or reused
  as the catalogue publisher key.

## Storage

Pruning reduces retained blockchain storage; it does not disable validation.
Use fast, reliable SSD/NVMe storage where practical, especially on ARM64
systems. Removing the package removes its YunoHost-managed data resource and
can delete a large blockchain dataset.

## Release provenance

Release archives are fetched from `bitcoincore.org` and pinned by SHA256 in
`manifest.toml`. Before updating the pin, verify the upstream `SHA256SUMS`
file and its detached signatures.
