require "json"
require "http/headers"
require "spec"
require "spec-kemal"
require "../../src/*"

require "kemal"

alias TravelPlan = Hash(String, Int32 | Array(Int32))

def create_sample_travel_location()
  travel = Travel.create()

  location_1 = Location.create({local: 2})
  location_2 = Location.create({local: 3})
  location_3 = Location.create({local: 7})

  travel_location_1 = TravelLocation.create({
        :travel_id => travel.id.to_s.to_i32,
        :location_id => location_1.id.to_s.to_i32
      })
  travel_location_2 = TravelLocation.create({
        :travel_id => travel.id.to_s.to_i32,
        :location_id => location_2.id.to_s.to_i32
      })
  travel_location_3 = TravelLocation.create({
        :travel_id => travel.id.to_s.to_i32,
        :location_id => location_3.id.to_s.to_i32
      })

  travel_plan = {
    "id" => travel.id.to_s.to_i32,
    "travel_stops" => [2,3,7]
  }

  travel_plan
end


describe "TravelPlan" do
  describe "POST /travel_plans" do
    it "Should create new Travel PLan" do
      data = { "travel_stops": [2,3,7] }
      response_status = 201
      sample = create_sample_travel_location()
      headers = HTTP::Headers{"Content-Type" => "application/json"}

      post "/travel_plans", headers: headers, body: data.to_json

      response.status_code.should eq response_status
      response_body = TravelPlan.from_json(response.body)
      response_body["id"].as(Int32).should eq sample["id"].as(Int32) + 1
      response_body["travel_stops"].should eq sample["travel_stops"]
    end
  end

  describe "GET /travel_plans" do

    it "Should retrieve Array of TravelPlans" do
      response_status = 200
      all_travels_locations = TravelLocation.all.results
      travels_locations = all_travels_locations.map do |travel_location|
        travel_id = travel_location["travel_id"].to_s.to_i32

        travel_plan = create_formated_return(travel_id)

        travel_plan
      end

      get "/travel_plans"

      response.status_code.should eq response_status
      response_body = Array(TravelPlan).from_json(response.body)
      typeof(response_body ).should eq Array(TravelPlan)
      response_body[0]["id"].as(Int32).should eq travels_locations[0]["id"].as(Int32)
      response_body[0]["travel_stops"].should eq travels_locations[0]["travel_stops"]
    end
  end

  describe "GET /travel_plans/:id" do

    it "Should retrieve a TravelPlan by Id" do
      response_status = 200
      sample = create_sample_travel_location()

      get "/travel_plans/#{sample["id"]}"

      response.status_code.should eq response_status
      response_body = TravelPlan.from_json(response.body)
      response_body["id"].as(Int32).should eq sample["id"].as(Int32)
      response_body["travel_stops"].should eq sample["travel_stops"]
    end
  end

  describe "PUT /travel_plans/:id" do

    it "Should update a TravelPlan by Id" do
      data = { "travel_stops": [4,5,6] }
      response_status = 200
      sample = create_sample_travel_location()
      headers = HTTP::Headers{"Content-Type" => "application/json"}

      put "/travel_plans/#{sample["id"]}", headers: headers, body: data.to_json

      response.status_code.should eq response_status
      response_body = TravelPlan.from_json(response.body)
      response_body["id"].as(Int32).should eq sample["id"].as(Int32)
      response_body["travel_stops"].should eq [4,5,6]
    end
  end

  describe "PATCH /travel_plans/:id" do

    it "Should add locations for a TravelPlan by Id" do
      data = { "travel_stops": [4,5,6] }
      response_status = 200
      sample = create_sample_travel_location()
      headers = HTTP::Headers{"Content-Type" => "application/json"}

      patch "/travel_plans/#{sample["id"]}/append", headers: headers, body: data.to_json

      response.status_code.should eq response_status
      response_body = TravelPlan.from_json(response.body)
      response_body["id"].as(Int32).should eq sample["id"].as(Int32)
      response_body["travel_stops"].should eq sample["travel_stops"].as(Array(Int32)) + [4,5,6]
    end
  end

  describe "DELETE /travel_plans/:id" do

    it "Should delete a TravelPlan by Id" do
      response_status = 204
      sample = create_sample_travel_location()

      delete "/travel_plans/#{sample["id"]}"

      response.status_code.should eq response_status
    end
  end

end
