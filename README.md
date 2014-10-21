ITCase.uwsgi
============

[Ansible](http://ansible.com) role which deploys wsgi application by uWSGI.

* Install and setup uWSGI.
* Deploy project with uWSGI.

#### Requirements & Dependencies

- [Stouts.deploy](https://github.com/Stouts/Stouts.deploy)

#### Variables

The role variables and default values.

```yaml
uwsgi_enabled: true                                    # Enable the role

# Emperor
uwsgi_initd: true                                      # Run daemon by init.d. If set false then run via Upstart

# emperor.ini
uwsgi_emperor: '/var/www/*/etc/uwsgi.ini'              # Pattern to vassals configs
uwsgi_emperor_daemonize: '/var/log/uwsgi/emperor.log'  # Emperor logs

# vassals-default.ini
uwsgi_vassal_procname_prefix: '%(vassal_name)-'        #
uwsgi_vassal_pidfile: '%(vassal_path)/run/uwsgi.pid'   # Default settings
uwsgi_vassal_socket: '%(vassal_path)/run/uwsgi.sock'   # which apllies to
uwsgi_vassal_logto: '%(vassal_path)/log/uwsgi.log'     # all vassals
uwsgi_vassal_venv: '/var/www/.venvs/%(vassal_name)'    #

# Vassal
uwsgi_vassal_user: '{{ deploy_user }}'
uwsgi_vassal_name: '{{ deploy_app_name }}'
uwsgi_vassal_etc_dir: '{{ deploy_etc_dir }}'
uwsgi_vassal_path: '{{ deploy_dir }}'
uwsgi_vassal_app: 'proj.wsgi'
uwsgi_vassal_options: [
  'env = LC_ALL=ru_RU.UTF-8',
  'env = LANG=ru_RU.UTF-8'
]
```

#### Usage

* Clone dependencies.
* Add `ITCase.uwsgi` to your roles and change variables in your playbook file.

Example:

```yaml
- hosts: all
  sudo: yes
  roles:
    - Stouts.deploy
    - ITCase.uwsgi
```

#### License

Licensed under the MIT License. See the LICENSE file for details.
