#!/bin/bash

app="${app:-${YNH_APP_ID:-bitcoin_core}}"
install_dir="${install_dir:-$(ynh_app_setting_get --app="$app" --key=install_dir 2>/dev/null || true)}"
data_dir="${data_dir:-$(ynh_app_setting_get --app="$app" --key=data_dir 2>/dev/null || true)}"
install_dir="${install_dir:-/var/www/$app}"
data_dir="${data_dir:-/home/yunohost.app/$app}"
service_name="$app"
config_dir="/etc/$app"
config_file="$config_dir/bitcoin.conf"
bitcoin_bin="$install_dir/bitcoin-31.1/bin/bitcoind"
bitcoin_cli="$install_dir/bitcoin-31.1/bin/bitcoin-cli"

ynh_bitcoin_prune_mb() {
	case "${pruning:-$(ynh_app_setting_get --app="$app" --key=pruning 2>/dev/null || echo pruned-25G)}" in
		pruned-10G) echo 10000 ;;
		pruned-25G) echo 25000 ;;
		pruned-50G) echo 50000 ;;
		pruned-100G) echo 100000 ;;
		full) echo 0 ;;
		*) ynh_die "Unknown pruning mode: ${pruning:-unset}" ;;
	esac
}

ynh_bitcoin_write_config() {
	local prune_mb
	prune_mb="$(ynh_bitcoin_prune_mb)"
	mkdir -p "$config_dir"
	{
		echo "# Managed by YunoHost package $app. Edit through the config panel when possible."
		echo "datadir=$data_dir"
		echo "server=1"
		echo "daemon=0"
		echo "disablewallet=1"
		echo "listen=${p2p_incoming:-$(ynh_app_setting_get --app="$app" --key=p2p_incoming 2>/dev/null || echo 1)}"
		echo "port=${p2p:-8333}"
		echo "rpcbind=127.0.0.1"
		echo "rpcallowip=127.0.0.1"
		echo "rpcport=8332"
		[ "$prune_mb" -gt 0 ] && echo "prune=$prune_mb"
	} > "$config_file"
	chown root:"$app" "$config_file"
	chmod 640 "$config_file"
}

ynh_bitcoin_unpack() {
	local archive="$install_dir/bitcoin-31.1-x86_64-linux-gnu.tar.gz"
	[ -f "$archive" ] || archive="$install_dir/bitcoin-31.1-aarch64-linux-gnu.tar.gz"
	tar -xzf "$archive" -C "$install_dir"
	rm -f "$archive"
	[ -x "$bitcoin_bin" ] || ynh_die "Bitcoin Core archive did not contain $bitcoin_bin"
	chown -R root:root "$install_dir"
	chmod -R o-rwx "$install_dir"
}

ynh_bitcoin_healthcheck() {
	"$bitcoin_cli" -conf="$config_file" -datadir="$data_dir" getnetworkinfo >/dev/null
}
