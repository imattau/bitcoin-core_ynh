# Bitcoin Core pour YunoHost

Paquet Bitcoin Core sans interface web pour YunoHost. Il fournit `bitcoind`
comme service local partagé pour Core Lightning, BTCPay et les explorateurs.

La configuration initiale utilise mainnet, un nœud élagué de 25 Go, un RPC
limité à `127.0.0.1:8332` et un portefeuille désactivé. Les binaires amd64 et
arm64 proviennent des archives officielles Bitcoin Core 31.1, vérifiées par
SHA256 et épinglées dans `manifest.toml`.

La synchronisation initiale continue en arrière-plan après l'installation.
Les sauvegardes incluent la configuration et les portefeuilles éventuels,
mais jamais `blocks/` ni `chainstate/`.

