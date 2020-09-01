# udata-docker-dev-env

Cloner le depot udata-docker-dev-env:

`git clone git@github.com:opendatateam/udata-docker-dev-env.git`

Cloner les deux dépots au sein du dossier créé:

```
git clone git@github.com:opendatateam/udata.git
git clone git@github.com:etalab/udata-gouvfr.git
```

Aller sein du dossier udata:

`cd udata`

Lancer les commandes suivantes:

```
npm install
npm run build
```

Remontez au dossier parent et lancez docker:

`cd .. & docker-compose up`
