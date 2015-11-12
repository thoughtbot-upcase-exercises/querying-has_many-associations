class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id
  has_many :employees, class_name: "Person", foreign_key: :manager_id

  def self.order_by_location_name
    all
  end

  def self.with_employees
    all
  end

  def self.with_employees_order_by_location_name
    all
  end
end
