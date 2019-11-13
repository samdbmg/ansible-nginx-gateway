Docker Framework Base
=========

Configures enough to expose various online services through docker-compose and
an nginx gateway, plus configures regular backups of volume mounts.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should
be mentioned here. For instance, if the role uses the EC2 module, it may be a
good idea to mention in this section that the boto package is required.

Role Variables
--------------

The role is configured by a big block of data describing all the services you
want to run. It's assumed you'll drop the Compose files into the right place and
start them, this deals with some of the supporting odds and ends. Something like:

```yaml
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
```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in
regards to parameters that may need to be set for other roles, or variables that
are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: ansible-docker-base, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
