def count_redisent_episodes(residents)
  resident_array_count_episodes = residents.map do |resident|
    if resident.size > 0
      resident["episode"].size
    else
      0
    end
  end

  resident_count_episodes = if resident_array_count_episodes.size > 0
      resident_array_count_episodes.reduce { |acc, i| acc + i }
  else
    0
  end

  resident_count_episodes
end

def count_dimension_appearence(travel_stops)
  travel_stops_dimensions = travel_stops.map do |stop|
    stop["dimension"]
  end
  travel_stops_dimensions = travel_stops_dimensions.uniq!

  dimensions_counts = travel_stops_dimensions.map do |dimension|
    counter = 0
    dimension_count = travel_stops.map do |stop|
      if stop["dimension"] == dimension
        counter += 1
      end
    end

    count = {
      "dimension" => dimension,
      "count" => counter,
    }

    count
  end

  dimensions_counts
end

def format_travel_stop_with_popularitys(travel_stops)
  dimensions_counts = count_dimension_appearence(travel_stops)
  travel_stops_popularity = travel_stops.map do |stop|
    residents = stop["residents"].as(Resident)

    resident_count_episodes = count_redisent_episodes(residents)
    new_stop = {
      "id" => stop["id"],
      "name" => stop["name"],
      "type" => stop["type"],
      "dimension" => stop["dimension"],
      "popularity" => resident_count_episodes
    }

    new_stop
  end

  dimensions_popularity = dimensions_counts.map do |dimension|
    counter = 0
     dimension_popularity = travel_stops_popularity.map do |stop|
        if stop["dimension"] == dimension["dimension"]
          counter += stop["popularity"].to_s.to_i32
        end
      end
      {
        "dimension" => dimension["dimension"],
        "dimension_popularity" => counter/dimension["count"].to_s.to_i32,
      }
  end

  stops_dimensions_popularity = travel_stops_popularity.map do |stop|
    dimension_popularity = dimensions_popularity.select { |dimension| dimension["dimension"] == stop["dimension"]}[0]["dimension_popularity"]
    {
      "id" => stop["id"],
      "name" => stop["name"],
      "type" => stop["type"],
      "dimension" => stop["dimension"],
      "popularity" => stop["popularity"],
      "dimension_popularity" => dimension_popularity
    }
  end

  popularity_formats = {
    "stops_dimensions_popularity" => stops_dimensions_popularity,
    "dimensions_popularity" => dimensions_popularity,
  }

  popularity_formats
end

def sort_alphabeticaly(array_to_sort, hash_dimension_key, hash_location_key)
  array_sorted = array_to_sort.map_with_index do |hash, index|
    if array_to_sort[index][hash_dimension_key].to_s.to_f32 == array_to_sort[index-1][hash_dimension_key].to_s.to_f32
      array_to_sort.sort_by! { |hash_to_sort| hash_to_sort[hash_location_key].to_s }
    else
      array_to_sort
    end
  end

  array_sorted
end

def sort_travles_stops(travel_stops)
  popularity_formats = format_travel_stop_with_popularitys(travel_stops)
  dimensions_popularity = popularity_formats["dimensions_popularity"]
  stops_dimensions_popularity = popularity_formats["stops_dimensions_popularity"]

  dimensions_by_popularity = dimensions_popularity.sort_by! { |dimension| dimension["dimension_popularity"].to_s.to_f32 }
  dimensions_by_popularity = sort_alphabeticaly(dimensions_by_popularity, "dimension_popularity", "dimension")

  stops_dimensions_by_dimension_popularaty = stops_dimensions_popularity.sort_by { |stop| stop["dimension_popularity"].to_s.to_f32 }
  stops_by_dimensions = dimensions_by_popularity[0].map do |dimension|
    dimension_stop_order_by_stop_popularity = stops_dimensions_by_dimension_popularaty.select { |stop| stop["dimension"] == dimension["dimension"]}.sort_by { |stop| stop["popularity"].to_s.to_i32 }
    dimension_stop_order_by_stop_popularity = sort_alphabeticaly(dimension_stop_order_by_stop_popularity, "popularity", "name")
    dimension_stop_order_by_stop_popularity[0]
  end
end

def remove_residents(travel_plan_expanded)
  travel_stops = travel_plan_expanded["travel_stops"]
  travel_stops.each do |stop|
    stop.delete("residents")
  end
end
