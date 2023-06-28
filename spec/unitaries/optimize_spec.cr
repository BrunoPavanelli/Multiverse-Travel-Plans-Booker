require "json"

require "../../src/*"

require "spec"
require "spec-kemal"

sample = {
  "id": 5,
  "travel_stops": [2,9,7,11,19]
}

result_non_expanded = {
  "id" => 5,
  "travel_stops" => [19,9,2,11,7]
}

result_expanded = {
  "id" => 5,
  "travel_stops" => [
    {
      "id" => 19,
      "name" => "Gromflom Prime",
      "type" => "Planet",
      "dimension" => "Replacement Dimension",
    },
    {
      "id" => 9,
      "name" => "Purge Planet",
      "type" => "Planet",
      "dimension" => "Replacement Dimension",
    },
    {
      "id" => 2,
      "name" => "Abadango",
      "type" => "Cluster",
      "dimension" => "unknown",
    },
    {
      "id" => 11,
      "name" => "Bepis 9",
      "type" => "Planet",
      "dimension" => "unknown",
    },
    {
      "id" =>  7,
      "name" => "Immortality Field Resort",
      "type" => "Resort",
      "dimension" => "unknown",
    }
  ]

}

describe "Optimize Travel Plan" do
  it "Should optimize an Travel Plan non expanded" do
    travel_plan_opitimized = optimize_travel_plan(sample, "false")

    travel_plan_opitimized["id"].should eq result_non_expanded["id"]
    travel_plan_opitimized["travel_stops"].should eq result_non_expanded["travel_stops"]
  end

  it "Should optimize an Travel Plan expanded" do

  travel_plan_opitimized = optimize_travel_plan(sample, "true")

  travel_plan_opitimized["id"].should eq result_expanded["id"]
  travel_plan_opitimized["travel_stops"].should eq result_expanded["travel_stops"]
  end
end
