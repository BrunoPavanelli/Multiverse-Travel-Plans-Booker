# Multiverse Rick and Morty Api Travel Planer

[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)

REST API example [Kemal](https://kemalcr.com/) to plan travels in Rick and Morty's Multiverse

## Features

- [Jennifer](https://imdrasil.github.io/jennifer.cr/), ORM for Crystal.
- [Rick and Morty API](https://rickandmortyapi.com), API used to get Rick and Morty's locations data
- Database use PostgreSQL.
- Unitaries and integrations specs.

## Endpoints

| HTTP Method | Path                     | Description                                              |
| ----------- | ------------------------ | -------------------------------------------------------- |
| GET         | /travel_plan             | Get all existing travel plans data                       |
| GET         | /travel_plan /:id        | Get existing travel plan data by Id                      |
| POST        | /api/travel plan         | Insert new customer travel plan                          |
| PUT         | /travel plan /:id        | Change all locations in existing travel plan data by Id  |
| PATCH       | /travel plan /:id/append | Add new locations in existing travel plan data by Id     |
| DELETE      | /travel plan/:id         | Delete existing travel plan data by Id                   |

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Contributors

- [Bruno Pavanelli](https://github.com/BrunoPavanelli) - Creator and Maintainer