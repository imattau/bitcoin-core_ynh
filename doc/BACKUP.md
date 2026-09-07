# Backup policy

The package backs up `/etc/bitcoin_core/bitcoin.conf` and any Bitcoin Core
wallet files under the data directory. It deliberately excludes `blocks/`,
`chainstate/`, indexes and peer databases: those are reproducible from the
Bitcoin network and may consume hundreds of gigabytes.

For Lightning deployments, keep funds in the Lightning application's own
backup/recovery system; this package is intended to run with the Bitcoin Core
wallet disabled.

