# udata-docker-dev-env

Cloner le depot udata-docker-dev-env:

`git clone git@github.com:opendatateam/udata-docker-dev-env.git`

Cloner les deux dépots au sein du dossier créé:

```
git clone git@github.com:opendatateam/udata.git
git clone git@github.com:etalab/udata-gouvfr.git
```

Changer de branche dans le dépôt udata:

```
cd udata
git checkout remove-theme
```

Changer de branche dans le dépôt udata-gouvfr:

```
cd udata-gouvfr
git checkout main-theme
```

Aller sein du dossier udata:

`cd udata`

Lancer les commandes suivantes:

```
npm install
npm run build
```

Remontez au dossier parent et lancez Docker Compose:

`cd .. & docker-compose up`
