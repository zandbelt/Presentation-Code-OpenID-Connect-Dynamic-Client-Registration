#!/bin/bash
read -r -d "" registration_input << EOF
{
  "application_type":           "web",
  "redirect_uris":             ["http://localhost:4000/callback"],
  "client_name":                "Example Dynamic Client",
  "logo_uri":                   "https://www.pingidentity.com/etc/designs/pic/clientlibs-all/logos/PingIdentity_logo.png",
  "subject_type":               "pairwise",
  "token_endpoint_auth_method": "client_secret_basic",
  "contacts":                  ["dwaite@pingidentity.com"]
}
EOF
echo "Registration Input:"
echo $registration_input | jq .

export registration_output=$(
  echo $registration_input |
  curl -s -v "https://mitreid.org/register" --data-binary @/dev/stdin -H "Content-Type: application/json"
)

echo
echo "Registration Output:"
echo $registration_output | jq .

echo 
echo "Client Credentials:"
export client_id=$(echo -n $registration_output | jq -r .client_id | tr -d '\n' )
export client_secret=$(echo -n $registration_output | jq -r .client_secret | tr -d '\n')
echo $client_id
echo $client_secret