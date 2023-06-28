class TravelLocation < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    location_id: Int32,
    travel_id: Int32,
    created_at: Time?,
    updated_at: Time?,
  )

  has_many :locations, Location
  has_many :travels, Travel
end
