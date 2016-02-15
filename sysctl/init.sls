# -*- coding: utf-8 -*-
# vim: ft=sls

{% from 'sysctl/map.jinja' import sysctl_settings with context %}

sysctl-package:
  pkg.installed:
    - name: {{ sysctl_settings.pkg }}
    - failhard: True


{% for param in sysctl_settings.get('params', {}) %}
sysctl-param-{{ param.name }}:
  sysctl.present:
    - name: {{ param.name }}
    - value: {{ param.value }}
    {% if param.config is defined and salt['file.directory_exists'](sysctl_settings.conf) %}
    - config: {{ sysctl_settings.conf }}/{{ param.config }}
    {% endif %}
{% endfor %}
