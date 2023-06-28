require "http/client"

require "../config/config.cr"

require "kemal"
require "crystal-gql"
require "marionette"

class Settings
  class_property host : String = "127.0.0.1", port = 3000
end

VERSION = "0.1.0"

Kemal.run
