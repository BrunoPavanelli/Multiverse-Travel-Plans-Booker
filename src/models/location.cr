class Location < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    local: Int32,
    created_at: Time?,
    updated_at: Time?,
  )
end
