# ddns.sh for Cloudflare
This project was created because cloudflare-python had incompatabilities, the ddclient package for cloudflare is against v1 instead of v4 of the API, and [the cloudflare docs](https://developers.cloudflare.com/api/operations/dns-records-for-a-zone-update-dns-record) seemed simple enough!

## Dependencies
Requires `zsh`, `curl`, and `jq`. Reaches out to [icanhazip.com](icanhazip.com) and [api.cloudflare.com](api.cloudflare.com).

## Configuration
copy ddns.conf.example to ddns.conf, change the variables according to its inline documentation.

## Installation
After configuration, run the shell script `./install.sh` to install as a SystemD unit with a daily timer. This operation requires `sudo` and `systemctl`.
