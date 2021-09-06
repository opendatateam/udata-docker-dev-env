# udata-docker-dev-env

Cloner le depot udata-docker-dev-env:

`git clone git@github.com:opendatateam/udata-docker-dev-env.git`

Cloner les deux dépots au sein du dossier créé:

```
git clone git@github.com:opendatateam/udata.git
git clone git@github.com:etalab/udata-gouvfr.git
```

Dans le dépôt udata:

```
cd udata
npm install
npm run build
```

Dans le dépôt udata-gouvfr:

```
cd udata-gouvfr
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

### Créer des fixtures

```
docker exec -it udata-docker-dev-env_udata_1 generate-fixtures
```

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

## Indexation (moteur de recherche et listes)

```
udata search index
# il est possible de filtre par modèle
udata search index Dataset
```

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

## Couverture spatiale

1. Récupérer et indexer le référentiel des zones géo

```
cd udata
wget https://static.data.gouv.fr/resources/geozones/20190513-134502/geozones-france-2019-0-msgpack.tar.xz
# penser à casser un oeuf sur son CPU à partir d'ici, oeuf au plat garanti
# prévoir également un bon bouquin
docker exec -it udata-docker-dev-env_udata_1 udata spatial load /srv/udata/geozones-france-2019-0-msgpack.tar.xz
rm geozones-france-2019-0-msgpack.tar.xz
docker exec -it udata-docker-dev-env_udata_1 udata search index Geozones
```

2. Ajouter une couverture spatiale sur un jeu de données

- éditer un jeu de données dans l'admin
- dans le champ couverture spatiale, taper "toulouse" par exemple et choisir une zone
- sauvegarder

## Statut dispo / non dispo pour une ressource

- Mettre une ressource dispo et une non dispo via le shell :

```
$ docker exec -it udata-docker-dev-env_udata_1 udata shell
>>> from udata.models import Dataset
>>> ds = Dataset.objects[:2]
>>> ds[0].resources[0].extras['check:available'] = True
>>> ds[0].resources[0].save()
>>> ds[0].save()
<Dataset: Namé reiciendisé incidunté quisé explicaboé eaqueé reiciendisé officiisé.>
>>> ds[1].resources[0].extras['check:available'] = False
>>> ds[1].resources[0].save()
>>> ds[1].save()
<Dataset: Accusantiumé minusé accusamusé veroé.>
>>> ds[0].slug, ds[1].slug
('name-reiciendise-incidunte-quise-explicaboe-eaquee-reiciendise-officiise', 'accusantiume-minuse-accusamuse-veroe')
```

- Les slugs permettent ensuite de retrouver les jeux de données sur le site

- La logique existante ici https://github.com/opendatateam/udata/blob/master/js/components/dataset/resource/availability.vue devrait maintenant matcher.
