# nexus compose

Local development services in one compose file. Not meant for production.

## Setup
```
$> cp .env.example .env     # then fill in the values, .env is git-ignored
$> docker compose up -d postgres redis
$> docker compose up <Service name> -d
```

`*_URLENCODED` passwords must be the same password as their plain counterpart, URL-encoded (`@` -> `%40`, `!` -> `%21`).

### Databases in PostgreSQL
`postgres/extensions/init-multi-postgres-databases.sh` creates every database listed in `POSTGRES_MULTIPLE_DATABASES` (`nexus`, `sonarqubedb`, `redmine`, `apidog`, `infisical`, `gitea`), owned by the `nexus` user. It only runs when `./postgres/data` is empty. For an existing data directory, run it by hand, it skips databases that already exist:
```
$> docker compose up -d postgres
$> docker exec nexus-postgres bash /docker-entrypoint-initdb.d/init-multi-postgres-databases.sh
```

### Gitea runner
Start `gitea` and finish the first-run install at http://localhost:4500, create a runner token under Site Administration > Actions > Runners, put it in `.env` as `GITEA_RUNNER_REGISTRATION_TOKEN`, then start `gitea-runner`.

### Apidog
Needs an Apidog On-Premises license in `APIDOG_LICENSE`.

## Stop Service
```
$> docker compose stop <Service name>
```

## Remove service
```
$> docker compose down
```

## Service list
| Service | Image | Host ports |
|---|---|---|
| postgres | postgres | 5432 |
| redis | redis | 6379 |
| mongo | mongo | 27017 |
| mysql | mysql | 3306 |
| oracle | gvenzl/oracle-xe | 1521 |
| mssqlserver | mssql/server | 1443 |
| pocketbase | pocketbase (built) | 8090 |
| azurite | azurite | 10000-10002 |
| adminer | adminer | 4012 |
| pgadmin | pgadmin4 | 4108 |
| rabbit | rabbitmq management | 4104 (amqp), 4105 (ui) |
| sonarqube | sonarqube community | 9900 |
| redmine | redmine | 3202 |
| elasticsearch | elasticsearch | 9200 |
| kibana | kibana | 5601 |
| consul | consul (built) | 8500 |
| vault | vault (built) | 8200 |
| jenkin | jenkins (built) | 8080, 50000 |
| jaeger | jaeger all-in-one | 16686 (ui), 4317/4318 (otlp), 9411 (zipkin) and others |
| gitea | gitea | 4500 (web), 2222 (ssh) |
| gitea-runner | gitea act_runner | none |
| apidog | apidog-ee | 4300 |
| infisical | infisical | 4400 |

Image tags are pinned in `docker-compose.yaml`. `docker-compose-confluentinc-aio.yaml` is a separate Kafka stack and is not part of this one.
