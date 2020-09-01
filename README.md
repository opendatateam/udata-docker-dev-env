# udata-docker-dev-env

Cloner le depot udata-docker-dev-env:

`git clone git@github.com:opendatateam/udata-docker-dev-env.git`

Cloner les deux dépots au sein du dossier créé:

`git clone git@github.com:opendatateam/udata.git`
`git clone git@github.com:etalab/udata-gouvfr.git`

Copier le fichier `udata.cfg`, le `Dockerfile` ainsi que le fichier `start.sh` dans le dossier udata.

Au sein du dossier udata, lancer les commandes suivantes:

`npm install`
`npm run build`
`npm run widgets:build`

Puis à la racine du dépot udata-docker-dev-env:

`docker-compose up`

