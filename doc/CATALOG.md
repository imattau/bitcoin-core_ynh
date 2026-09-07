# Nostr Catalog checklist

The local `nostr_catalog_ynh` package publishes a signed declaration from a
public repository containing `manifest.toml`. The declaration records:

- app id: `bitcoin_core`;
- package version: `31.1~ynh1`;
- canonical repository URL and exact Git commit;
- SHA256 of the exact `manifest.toml`;
- SHA256 of the repository tree at that commit.

The repository must therefore be committed and publicly fetchable before
publication. Publishing is performed from the Nostr Catalog Publisher panel
using the repository URL and ref; it is not inferred from
`[upstream].code`, which points to Bitcoin Core itself.

The package's `.github/workflows/static-security.yml` calls the reusable
workflow from `imattau/nostr-yunohost`. That workflow performs static checks
and produces the unsigned CI result. A separate protected workflow can run
`nostr-ynh attest` with a dedicated verifier secret when the catalogue trust
policy requires a `package_check` attestation for the exact commit.

Do not put either the catalogue publisher private key or CI verifier private
key in this repository. The two identities should remain separate.

