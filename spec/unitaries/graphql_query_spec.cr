require "json"

require "../../src/*"

require "spec"
require "spec-kemal"

sample = {
  "id"=> "2",
  "name"=> "Abadango",
  "dimension"=> "unknown",
  "residents"=> [
    {
      "episode"=> [
        {
          "episode"=> "S03E06"
        }
      ]
    }
  ]
}

describe "Get data from Location using GraphQl" do
  it "Should return data from Location" do
    sample_id = sample["id"].to_s.to_i32
    location_data = get_locations_from_rm_api(sample_id)["location"]
    episode_data = "S03E06"

    location_data["id"].should eq sample["id"]
    location_data["name"].should eq sample["name"]
    location_data["dimension"].should eq sample["dimension"]
    location_data["residents"].should eq sample["residents"]
  end
end

