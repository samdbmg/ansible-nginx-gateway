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
services:
  webserver:
    type: static
    data_directory:
      - /var/www-data
  irc:
    type: reverse-proxy
    port: 8081
    client_ca_cert: /etc/client-ca.crt
    data_directory:
      - /var/irc-data
```

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - role: ansible-docker-base
           vars:
            services:
              webserver:
                type: static
                data_directory:
                  - /var/www-data
              irc:
                type: reverse-proxy
                port: 8081
                client_cert: /etc/client-ca.crt
                data_directory:
                  - /var/irc-data

License
-------

Apache

Author Information
------------------

Sam Mesterton-Gibbons (@samdbmg)
