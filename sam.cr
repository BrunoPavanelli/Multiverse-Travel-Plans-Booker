require "./config/*"
require "jennifer/adapter/postgres"
require "jennifer"
require "./db/migrations/*"
require "sam"
require "jennifer/sam"
load_dependencies "jennifer"

Sam.help
