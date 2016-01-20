class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id
  has_many :employees, class_name: "Person", foreign_key: :manager_id

  def self.order_by_location_name
    joins(:location).merge(Location.order(:name))
  end

  def self.with_employees
    joins(:employees).distinct
  end

  def self.with_employees_order_by_location_name
    from(Person.with_employees, :people).order_by_location_name
  end
end
