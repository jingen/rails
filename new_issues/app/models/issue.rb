class Issue < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title, message: "should be unique, sir."
	validates_length_of :description, minimum: 10, maximum: 12
	validates_numericality_of :no_followers, allow_blank: true

	validates_with Yesnovalidator
	# belongs_to :project

	# has_many :projects, through: :join_model
	has_many_and_belongs_to :projects
end

