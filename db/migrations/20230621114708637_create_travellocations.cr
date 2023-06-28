class CreateTravellocations < Jennifer::Migration::Base
  def up
    create_table :travel_locations do |t|
      t.integer :location_id, {:null => false}
      t.integer :travel_id, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :travel_locations if table_exists? :travel_locations
  end
end
