class Project < ActiveRecord::Base

	has_many :issues
	# has_one :issue
	# has_many :issues, through: :join_model 
	# has_and_belongs_to_many :issues
end
