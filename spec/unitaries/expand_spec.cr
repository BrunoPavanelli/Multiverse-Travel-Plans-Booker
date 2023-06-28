require "json"

require "../../src/*"

require "spec"
require "spec-kemal"

sample = {
  "id": 2,
  "travel_stops": [2, 10]
}

location_1 = {
  "id"=> 2,
  "name"=> "Abadango",
  "type" => "Cluster",
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

location_2 = {
  "id" => 10,
  "name" => "Venzenulon 7",
  "type" => "Planet",
  "dimension" => "unknown",
  "residents" => [
    {
      "episode" => [
        {
          "episode" => "S03E08"
        }
      ]
    }
  ]
}

describe "Expand Travel Plan" do
  it "Should expand an Travel Plan" do
    travel_plan_expanded = expand_travel_plan(sample)

    travel_plan_expanded["id"].should eq sample["id"]
    travel_plan_expanded["travel_stops"][0].should eq location_1
    travel_plan_expanded["travel_stops"][1].should eq location_2
  end
end
