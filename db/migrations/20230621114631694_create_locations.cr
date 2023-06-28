class CreateLocations < Jennifer::Migration::Base
  def up
    create_table :locations do |t|
      t.integer :local, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :locations if table_exists? :locations
  end
end
