class Course
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :no_followers, type: Integer
end
