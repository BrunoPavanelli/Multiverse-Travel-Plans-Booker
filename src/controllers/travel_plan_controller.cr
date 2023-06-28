require "marionette"

get "/travel_plans/:id/locations_img" do |env|
  travel_plan_id = env.params.url["id"].to_i32
  travel_plan = Travel.find(travel_plan_id)

  unless travel_plan.nil?
    travel_plan_formated = create_formated_return(travel_plan_id)
    travel_stops = travel_plan_formated[:travel_stops]


    travel_stop_with_locations_names = travel_stops.map do |location|
      name = get_locations_name(location)
      stop_named = {
        "id" => location,
        "name" => name
      }
    end

    session = Marionette::WebDriver.create_session(:chrome)
    session.navigate "https://rickandmorty.fandom.com/wiki/Category:Locations"

    travel_stops_with_imgs_src = travel_stop_with_locations_names.map do |stop|
      location_id = stop["id"]
      location_name = stop["name"]

      location_img = session.find_element("img[alt='#{location_name}']", :tag_name)
      location_img_src = ""

      if location_img.nil?
        location_img_src = "Image not Found :("
      else
        location_img_src = location_img.property("src")
      end


      location_with_img_src = {
        "id" => location_id,
        "img_src" => location_img_src
      }

      location_with_img_src
    end
  else
    env.response.status_code = 404
  end

  travel_plan_with_locations_img_src = {
    "id" => travel_plan_id,
    "travel_stops" => travel_stops_with_imgs_src
  }

  travel_plan_with_locations_img_src.to_json
end

post "/travel_plans" do |env|
  env.response.content_type = "application/json"
  locations = env.params.json["travel_stops"].as(Array)
  new_travel = Travel.create()
  new_travel_id = new_travel.id.to_s.to_i32

  create_travel_location(locations, new_travel_id)

  env.response.status_code = 201
  create_formated_return(new_travel_id).to_json
end

get "/travel_plans" do |env|
  env.response.content_type = "application/json"
  all_travels_locations = TravelLocation.all.results
  is_expanded = env.params.query["expand"]?
  is_optimized = env.params.query["optimize"]?

  travels_locations = all_travels_locations.map do |travel_location|
    travel_id = travel_location["travel_id"].to_s.to_i32

    travel_plan = create_formated_return(travel_id)

    recieve_querys_params_and_process_return(travel_plan, is_expanded, is_optimized)
  end

  travels_locations.uniq!.to_json
end

get "/travel_plans/:id" do |env|
  env.response.content_type = "application/json"
  travel_plan_id = env.params.url["id"].to_i32
  is_expanded = env.params.query["expand"]?
  is_optimized = env.params.query["optimize"]?

  travel_plan = create_formated_return(travel_plan_id)

  unless travel_plan["travel_stops"].size == 0
    recieve_querys_params_and_process_return(travel_plan, is_expanded, is_optimized).to_json
  else
    env.response.status_code = 404
  end
end

patch "/travel_plans/:id/append" do |env|
  env.response.content_type = "application/json"
  travel_id = env.params.url["id"].to_i32
  travel_plan = Travel.find(travel_id)

  unless travel_plan.nil?
    locations = env.params.json["travel_stops"].as(Array)
    create_travel_location(locations, travel_id)

    travel_plan = create_formated_return(travel_id)
    travel_plan.to_json
  else
    env.response.status_code = 404
  end
end

put "/travel_plans/:id" do |env|
  env.response.content_type = "application/json"
  travel_plan_id = env.params.url["id"].to_i32
  travel_plan_to_put = Travel.find(travel_plan_id)

  unless travel_plan_to_put.nil?
    remove_travel_locations(travel_plan_id)
    locations = env.params.json["travel_stops"].as(Array)

    travel_plan_to_put_id = travel_plan_to_put.id.to_s.to_i32
    create_travel_location(locations, travel_plan_to_put_id)

    travel_plan = create_formated_return(travel_plan_to_put_id)
    travel_plan.to_json
  else
    env.response.status_code = 404
  end

end

delete "/travel_plans/:id" do |env|
  env.response.content_type = "application/json"
  travel_plan_id = env.params.url["id"].to_i32
  travel_plan_to_delete = Travel.find(travel_plan_id)

  unless travel_plan_to_delete.nil?
    remove_travel_locations(travel_plan_id)

    env.response.status_code = 204
    Travel.delete(travel_plan_id)
  else
    env.response.status_code = 404
  end
end
