Bitcoin Core is packaged here as a headless, shared infrastructure service
for YunoHost. It runs `bitcoind` under a dedicated system user, validates and
relays the Bitcoin network, and provides a localhost-only RPC endpoint for
dependent applications such as Core Lightning, BTCPay and explorers.

The package has no web interface or domain requirement. Mainnet is the
default network, pruning is enabled by default, and the Bitcoin Core wallet
is disabled so Lightning applications can remain responsible for funds.

