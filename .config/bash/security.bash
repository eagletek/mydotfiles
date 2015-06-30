# Public/Private RSA key pairs as used by OAuth in Atlassian tools
function rsa_key_gen() {
    openssl genrsa -out rsa.pem 1024
    openssl rsa -in rsa.pem -pubout -out rsa.pub
}
