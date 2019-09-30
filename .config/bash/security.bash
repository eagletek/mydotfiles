# Public/Private RSA key pairs as used by OAuth in Atlassian tools
function rsa_key_gen() {
    openssl genrsa -out rsa.pem 1024
    openssl rsa -in rsa.pem -pubout -out rsa.pub
}

function randpass() {
  local length="${1:-16}"
  tr -dc A-Za-z0-9_.\!@#% < /dev/urandom | head -c "${length}";echo;
}
