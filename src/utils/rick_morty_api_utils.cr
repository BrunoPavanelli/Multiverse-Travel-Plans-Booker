require "./ricky_morty_api_support.cr/*"
require "crystal-gql"

alias Episode = Hash(String,String)
alias Episodes = Array(Episode)
alias Resident = Array(Hash(String, Episodes))
alias TravelStop = Hash(String, String | Resident)
alias LocationName = Hash(String, Hash(String, String))

def make_graphl_ql_api_client()
  GraphQLClient.new "https://rickandmortyapi.com/graphql"
end

def get_locations_from_rm_api(id : Int32)
  api = make_graphl_ql_api_client()
  data, error, loading = api.query("{
    location(id: #{id}) {
      id
      name
      type
      dimension
      residents {
        episode {
          episode
        }
      }
    }
  }")

  data_converted = data.to_s.gsub("=>") {":"}
  location = Hash(String, TravelStop).from_json(data_converted)

  return location
end

def get_locations_name(id : Int32)
  api = make_graphl_ql_api_client()
  data, error, loading = api.query("{
    location(id: #{id}) {
      name
    }
  }")

  data_converted = data.to_s.gsub("=>") {":"}

  location = LocationName.from_json(data_converted)
  location_name = location["location"]["name"]

  location_name
end

def expand_travel_plan(travel_plan)
  travel_stops = travel_plan["travel_stops"]

  travel_stops_expand = travel_stops.map do |stop|
    stop_id = stop
    expand_stop = get_locations_from_rm_api(stop_id)

    stop = expand_stop["location"]
  end
  travel_plan_expanded = {
    id: travel_plan["id"].to_s.to_i32,
    travel_stops: travel_stops_expand.map do |travel_stop|
      {
        "id" => travel_stop["id"].to_s.to_i32,
        "name" => travel_stop["name"],
        "type" => travel_stop["type"],
        "dimension" => travel_stop["dimension"],
        "residents" => travel_stop["residents"]
      }
    end.reject { |stop| stop == nil }
  }
  return travel_plan_expanded
end

def optimize_travel_plan(travel_plan, is_expanded)
  travel_plan_expanded = expand_travel_plan(travel_plan)
  travel_stops = travel_plan_expanded["travel_stops"]

  sorted_stops_by_dimensions = sort_travles_stops(travel_stops)

  stops_optimized = sorted_stops_by_dimensions.flatten.map do |stop|
    stop_optimized = {
      "id" => stop["id"].to_s.to_i32,
      "name" => stop["name"],
      "type" => stop["type"],
      "dimension" => stop["dimension"],
    }
  end
  stops_optimized_only_id = stops_optimized.map do |travel_stop|
    travel_stop["id"].to_s.to_i32
  end

  travel_stops_optimized = {
    "id" => travel_plan["id"].to_s.to_i32,
    "travel_stops" =>   is_expanded == "true" ? stops_optimized : stops_optimized_only_id
  }

  travel_stops_optimized
end

def recieve_querys_params_and_process_return(travel_plan, is_expanded, is_optimized)
  if is_optimized == "true"
    travel_plan_expanded_optimized = optimize_travel_plan(travel_plan, is_expanded)

    travel_plan_expanded_optimized
  elsif is_expanded == "true"
    travel_plan_expanded = expand_travel_plan(travel_plan)
    remove_residents(travel_plan_expanded)

    travel_plan_expanded
  else
    travel_plan
  end
end

