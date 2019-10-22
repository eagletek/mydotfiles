# Public/Private RSA key pairs as used by OAuth in Atlassian tools
function rsa_key_gen() {
    openssl genrsa -out rsa.pem 1024
    openssl rsa -in rsa.pem -pubout -out rsa.pub
}

function randpass() {
  local length="${1:-16}"
  tr -dc A-Za-z0-9_.\!@#% < /dev/urandom | head -c "${length}";echo;
}

function gen_self_signed_cert() {
  local servername="${1:-localhost}"
  local altname="${servername%%.*}"
  local santext="[SAN]\nsubjectAltName=DNS:${servername}"
  if [[ "${altname}" != "${servername}" ]]; then
    santext="${santext},DNS:${altname}"
  fi
  openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout ${servername}.key \
    -new \
    -out ${servername}.crt \
    -subj /CN=${servername} \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
            <(printf "${santext}")) \
    -sha256 \
    -days 3650
}

function view_cert() {
  openssl x509 -in "${1}" -text -noout
}
