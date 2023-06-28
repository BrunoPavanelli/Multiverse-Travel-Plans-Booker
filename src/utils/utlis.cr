def create_formated_return(travel_id : Int32)
  travel_location = TravelLocation.where { _travel_id == travel_id }.results

  stops = travel_location.map do |travel|
    location_id = travel.location_id.to_s.to_i32
    location = Location.where { _id == location_id }.first!
    location.local.to_s.to_i32
  end

  return_body = {
    "id": travel_id.to_i32,
    "travel_stops": stops
  }
end

def create_travel_location(location_list : Array, travel_id : Int32)
  location_list.map do |location|
    local_in_db = Location.where { _local == location }.first

    if local_in_db.nil?
      new_location = Location.create({local: location.to_s.to_i32})
      new_location_id = new_location.id.to_s.to_i32

      TravelLocation.create({
        :travel_id => travel_id,
        :location_id => new_location_id
      })
    else
      TravelLocation.create({
        :travel_id => travel_id,
        :location_id => local_in_db.id.to_s.to_i32
      })
    end
  end
end

def remove_travel_locations(travel_plan_id : Int32)
  travel_location = TravelLocation.where { _travel_id == travel_plan_id }.results
  travel_location.map do |travel|
    TravelLocation.delete(travel.id.to_s.to_i32)
  end
end
