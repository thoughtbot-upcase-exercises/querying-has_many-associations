require "spec_helper"

describe Person do
  describe ".order_by_location_name" do
    it "groups people by location" do
      # pending "Fix this spec first"

      locations = [
        create(:location, name: "location1"),
        create(:location, name: "location3"),
        create(:location, name: "location2")
      ]
      locations.each do |location|
        create(:person, location: location, name: "at-#{location.name}")
      end

      result = Person.order_by_location_name

      expect(result.map(&:name)).
        to eq(%w(at-location1 at-location2 at-location3))
    end
  end

  describe ".with_employees" do
    it "finds people who manage employees" do
      # pending "Fix this spec second"

      managers = [
        create(:person, name: "manager-one"),
        create(:person, name: "manager-two")
      ]
      managers.each do |manager|
        2.times do
          create(:person, name: "employee-of-#{manager.name}", manager: manager)
        end
      end

      result = Person.with_employees

      expect(result.map(&:name)).to match_array(%w(manager-one manager-two))
    end
  end

  describe ".with_employees_order_by_location_name" do
    it "finds managers ordered by location name" do
      # pending "Fix this spec last"

      locations = [
        create(:location, name: "location1"),
        create(:location, name: "location3"),
        create(:location, name: "location2")
      ]
      managers = locations.map do |location|
        create(:person, name: "manager-at-#{location.name}", location: location)
      end
      managers.each do |manager|
        2.times do
          create(:person, name: "employee-of-#{manager.name}", manager: manager)
        end
      end

      result = Person.with_employees_order_by_location_name

      expect(result.map(&:name)).to eq(%w(
        manager-at-location1
        manager-at-location2
        manager-at-location3
      ))
    end
  end
end
