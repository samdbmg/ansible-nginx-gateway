#!/bin/bash
set -ex

# Generate a directory to work in
rm -Rf generated-certs
mkdir generated-certs

(
    cd generated-certs

    # Generate root key and CA
    openssl genrsa -out fake-client-ca.key 1024
    openssl req -x509 -new -nodes -key fake-client-ca.key -sha256 -days 1024 -subj "/C=GB/ST=Manchester/O=Sample/CN=fake-client-cert." -out fake-client-ca.crt

    # Generate key for cert
    openssl genrsa -out fake-client-cert.key 1024

    # Generate CSR
    openssl req -new -sha256 -key fake-client-cert.key -subj "/C=GB/ST=Manchester/O=Sample/CN=user@fake-client-cert." -out fake-client-cert.csr

    # Generate cert
    openssl x509 -req -in fake-client-cert.csr -CA fake-client-ca.crt -CAkey fake-client-ca.key -CAcreateserial -out fake-client-cert.crt -days 500 -sha256

    # Generate cert PEM file
    cat fake-client-cert.crt fake-client-cert.key > fake-client-cert.pem
)