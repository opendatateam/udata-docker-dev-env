#! /bin/bash

pip install -r /srv/udata/requirements/develop.pip
pip install -e /srv/udata/
pip install -e /srv/udata-gouvfr
pip install udata-tabular-preview
udata db migrate
udata search index
udata generate-fixtures
cd /srv/udata && inv serve --host 0.0.0.0
