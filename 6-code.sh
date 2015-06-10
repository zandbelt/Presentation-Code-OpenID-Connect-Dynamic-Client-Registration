#!/bin/bash
export code=$1
( set -x
curl -s -v -u $client_id:$client_secret \
"https://mitreid.org/token\
?grant_type=authorization_code\
&code=$code\
&redirect_uri=http://localhost:4000/callback" | jq .
)
echo