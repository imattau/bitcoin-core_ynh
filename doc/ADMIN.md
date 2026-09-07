# Administration

Check the service with `yunohost service status bitcoin_core` and inspect the
node with the local RPC client:

```sh
bitcoin-cli -conf=/etc/bitcoin_core/bitcoin.conf getblockchaininfo
bitcoin-cli -conf=/etc/bitcoin_core/bitcoin.conf getnetworkinfo
```

Applications on the same host should use RPC at `127.0.0.1:8332`. Do not open
the RPC port to the internet. Dependent packages should detect this service
and establish their own credentials in a future integration helper.

