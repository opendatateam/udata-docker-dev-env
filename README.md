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
npm install
npm run build
```

Changer de branche dans le dépôt udata-gouvfr:

```
cd udata-gouvfr
git checkout main-theme
npm install
npm run build
```

Remontez au dossier parent et lancez Docker Compose:

`cd .. & docker-compose up`

## Cache

### Désactiver complètement le cache

Dans `udata.cfg` :

```
CACHE_TYPE = 'null'
```

### Désactiver le cache de templates

(A tester, pas sûr)

```
TEMPLATE_CACHE_DURATION = -1
```

### Vider le cache à la main

```
docker exec -it udata-docker-dev-env_udata_1 udata cache flush
```

## Contenu / utilisateurs

### Créer un admin

```
docker exec -it udata-docker-dev-env_udata_1 udata user create
docker exec -it udata-docker-dev-env_udata_1 udata user set-admin <email>
```

### Peupler la home

- se logguer avec un admin
- aller sur http://localhost:7000/fr/admin/editorial/
- choisir des jeux de données et des réutilisations
- aller sur la page d'une réutilisation en admin et cliquer sur "Mis en avant"
- flusher le cache si besoin


## Compiler les traductions

### udata

```
docker exec -it udata-docker-dev-env_udata_1 "cd /srv/udata && inv i18nc"
```

### udata-gouvfr

```
docker exec -it udata-docker-dev-env_udata_1 "cd /srv/udata-gouvfr && inv i18nc"
```

## Activer la preview de CSV

1. S'assurer que `udata.cfg` contient bien `tabular` dans les `PLUGINS` et que le dernier `start.sh` est bien passé en installant `udata-tabular-preview`.

```
docker-compose build udata
docker-compose up
```

2. Créer une ressource distante sur un jeu de données :
- url : https://static.data.gouv.fr/resources/donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/20201028-190138/donnees-hospitalieres-nouveaux-covid19-2020-10-28-19h00.csv
- format : csv
- mime : text/csv
- taille : 1000

3. La ressource devrait avoir un attribut `preview_url` rempli, c'est celui sur lequel se base la preview existante, par exemple avec `/tabular/preview/?url=https%3A%2F%2Fstatic.data.gouv.fr%2Fresources%2Fdonnees-hospitalieres-relatives-a-lepidemie-de-covid-19%2F20201028-190138%2Fdonnees-hospitalieres-nouveaux-covid19-2020-10-28-19h00.csv`
