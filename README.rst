======
Sysctl
======

Formula for managing sysctl parameters

Tested with the following platforms:

- CentOS 7
- Debian 7 (Wheezy)
- Debian 8 (Jessie)
- OpenSUSE 13
- Oracle Linux 7
- Ubuntu 12.04 (Precise)
- Ubuntu 14.04 (Trusty)
- Ubuntu 15.04 (Vivid)

----


``sysctl``
----------

**Variables of Note**

- **params** - each param has the following parameters: name, value, config.

::

  sysctl:
    lookup:
      params:
        - name: <sysctl param>
          value: <value>
          config: <optional config file to append params to>


**Pillar Example:**

::

  sysctl:
    lookup:
      params:
        - name: fs.file-max
          config: 99fsparams
          value: 65535
        - name: vm.max_map_count
          value: 262144
        - name: vm.swappiness
          value: 1

----

