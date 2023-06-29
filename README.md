# Multiverse Travels Booker

[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)

REST API [Kemal](https://kemalcr.com/) to plan travels in Rick and Morty's Multiverse

## Features

- [Jennifer](https://imdrasil.github.io/jennifer.cr/), ORM for Crystal.
- [Rick and Morty API](https://rickandmortyapi.com), API used to get Rick and Morty's locations data
- Database use PostgreSQL.
- Unitaries and integrations specs.

## Installation

 - Run shards install
 - Run make sam db:create
 - Run make sam db:migrate
 - Create and full fill database.yml -> WARN: host must be db to work with docker compose and to run runtest

## Endpoints

| HTTP Method | Path                            | Description                                                     |
| ----------- | ------------------------------- | --------------------------------------------------------------- |
| GET         | /travel_plan                    | Get all existing travel plans data                              |
| GET         | /travel_plan /:id               | Get existing travel plan data by Id                             |
| GET         | /travel_plans/:id/locations_img | Get existing travel plan with img url source using webscrapping |
| POST        | /api/travel plan                | Insert new customer travel plan                                 |
| PUT         | /travel plan /:id               | Change all locations in existing travel plan data by Id         |
| PATCH       | /travel plan /:id/append        | Add new locations in existing travel plan data by Id            |
| DELETE      | /travel plan/:id                | Delete existing travel plan data by Id                          |

## Development

 - To run spec tests:
  - The db must be created and migrated, and database.yml file must be full filled with db in localhost
  - Run command KEMAL_ENV=test crystal spec

## Contributing

1. Fork it (<https://github.com/your-github-user/81917b7c5f3c52afd7dbdf49723fc8df70ac1704/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Bruno Pavanelli](https://github.com/BrunoPavanelli) - Creator and Maintainer
