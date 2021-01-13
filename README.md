NGINX Gateway
=========

Configures nginx as a gateway to host static sites and reverse-proxy
other ones. Supports per-site certificates, client certificate authentication
(mutual TLS) and uses an NGINX config from [nginxconfig.io](https://nginxconfig.io).

Requirements
------------

- You need to have your own certificate already

Role Variables
--------------

The role is configured by a big block of data describing all the sites you
want to run.

```yaml
sites:
  - name: sample-static-site # A name used in a few comments/filenames etc. (Required)
    type: static # `static` or `proxy` - whether the site is just on disk, or a reverse proxy (Required)
    domain: demo.example.com # The domain the site should be served from - you'll have to sort DNS yourself (Required)
    root: /var/www-data/something # For a static site, this is the location that the site's files are served from
                                  # (Required for type: static)
    use_by_default: false # Set this true for one site, to make it the one responded to by IP, Default: False
    allow_insecure: false # Set this to allow the site to serve unencrypted (caution, security risk!). Default: False
    client_ca_cert: /etc/ssl/certs/my-custom-ca.crt # Location of a CA cert that client certificates should be validated
                                                    # against - specifying makes client cert mandatory. Default: empty

  - name: sample-proxy-site # A name used in a few comments/filenames etc. (Required)
    type: proxy # `static` or `proxy` - whether the site is just on disk, or a reverse proxy (Required)
    domain: demo.example.com # The domain the site should be served from - you'll have to sort DNS yourself (Required)
    proxy_url: http://127.0.0.1:3000 # URL to proxy requests to, either localhost or remote (Required for type `proxy`)
    use_by_default: false # Set this true for one site, to make it the one responded to by IP, Default: False
    allow_insecure: false # Set this to allow the site to serve unencrypted (caution, security risk!). Default: False
    client_ca_cert: /etc/ssl/certs/my-custom-ca.crt # Location of a CA cert that client certificates should be validated
                                                    # against - specifying makes client cert mandatory. Default: empty
    use_proxy_host: false  # Usually you'll proxy an internal site and this webserver will be it's canonical location,
                           # so the `Host` header should match the server name. However sometimes you'll want to
                           # transparently proxy to an external site, in which case you need `use_proxy_host: True`.
                           # Mostly this is useful for the unit tests!. Default: False
```

Dependencies
------------

None

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
      - role: ansible-docker-base
        vars:
          server_cert: /etc/ssl/certs/server-chain.cert
          server_cert_key: /etc/ssl/private/server.key
          sites:
            webserver:
              type: static
              domain: example.com
              root: /var/www-data
            irc:
              type: proxy
              domain: irc.example.com
              proxy_url: http://localhost:8081
              client_ca_cert: /etc/client-ca.crt
```
License
-------

Apache

Author Information
------------------

Sam Mesterton-Gibbons (@samdbmg)
