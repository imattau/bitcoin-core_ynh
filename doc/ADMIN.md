# Administration

Check the service with `yunohost service status bitcoin_core` and inspect the
node with the local RPC client:

```sh
bitcoin-cli -conf=/etc/bitcoin_core/bitcoin.conf getblockchaininfo
bitcoin-cli -conf=/etc/bitcoin_core/bitcoin.conf getnetworkinfo
```

The install question “Start blockchain synchronization immediately?” is
enabled by default. If disabled, the package installs without starting
`bitcoind` or downloading blockchain data. Enable “Synchronization enabled” or
use “Start Bitcoin synchronization now” in the YunoHost Config Panel later.

Applications on the same host should use RPC at `127.0.0.1:8332`. Do not open
the RPC port to the internet. Dependent packages should detect this service
and establish their own credentials in a future integration helper.
