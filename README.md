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

Remoter d'un niveau:

`cd ..`

Puis à la racine du dépot udata-docker-dev-env:

`docker-compose up`
