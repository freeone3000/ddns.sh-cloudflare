#!/usr/bin/env zsh
set -e


function get_ip () {
  curl -s https://ipv4.icanhazip.com/
}

function cloudflare () {
    readonly IP=$1
    id=$(curl --request GET \
	    -s \
	    --header "X-Auth-Email: $AUTH_EMAIL" \
	    --header "X-Auth-Key: $AUTH_KEY" \
	    --url "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/" \
	| jq -r '.result[] | select(.name == "jamoo.dev") | select(.type == "A") | .id')

    success=$(curl --request PATCH \
	 -s \
	 --url "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${id}" \
	 --header "Content-Type: application/json" \
	 --header "X-Auth-Email: $AUTH_EMAIL" \
	 --header "X-Auth-Key: $AUTH_KEY" \
	 --data '{
	     "content": "'"$IP"'",
	     "name": "'"$RECORD_NAME"'",
	     "proxied": true,
	     "type": "A",
	     "comment": "Updated by ddns.sh",
             "tags": [],
             "ttl": 3600
         }' | jq -r ".result.success")
    if [[ ${success} == "true" ]]; then
	return 0
    else
	return 1
    fi
} 

# if config is specified via @fn, then load from that filename
if [[ ${1[1,1]} = '@' ]]; then
  fn=${1[2,-1]}
  . "$fn"
fi

# execute
ip=`get_ip`
cloudflare $ip
