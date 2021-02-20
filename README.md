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
want to run. Currently sites can either be statically served by NGINX, or
reverse-proxied somewhere else, such as a process bound to some port on
locahost. The two types of site have the following main (required) options:

```yaml
sites:
  - name: sample-static-site # A name used in a few comments/filenames etc. (Required)
    type: static # `static` or `proxy` - whether the site is just on disk, or a reverse proxy (Required)
    domain: demo.example.com # The domain the site should be served from - you'll have to sort DNS yourself (Required)
    root: /var/www-data/something # For a static site, this is the location that the site's files are served from
                                  # (Required for type: static)

  - name: sample-proxy-site # A name used in a few comments/filenames etc. (Required)
    type: proxy # `static` or `proxy` - whether the site is just on disk, or a reverse proxy (Required)
    domain: demo.example.com # The domain the site should be served from - you'll have to sort DNS yourself (Required)
    proxy_url: http://127.0.0.1:3000 # URL to proxy requests to, either localhost or remote (Required for type `proxy`)
```

There are some additional options supported by both types of site:
- `use_by_default`: Set this true for one site, to make it the one responded to by IP, Default: False
- `allow_insecure`: Set this to allow the site to serve unencrypted (caution, security risk!). Default: False
- `client_ca_cert`: Location of a CA cert that client certificates should be validated against - specifying makes client
                    cert mandatory. Default: empty
- `disable_csp`: Set to true to disable adding a default Content-Security-Policy header. Default: False
- `disable_security_headers`: By default a set of headers are included from nginxconfig.io/security.conf to apply some
                              opinionated security options, such as preventing access to dotfiles. Set this to turn
                              those protections off if you need to. Default: False
- `extra_config`: Any extra config lines to insert into this site's location block, although make sure you don't cause
                  accidental security risks. Default: empty

Dependencies
------------

None

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
      - role: samdbmg.nginx-gateway
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
