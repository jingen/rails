class Issue < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title, message: "should be unique, sir."
	validates_length_of :description, minimum: 10#, maximum: 12
	validates_numericality_of :no_followers, allow_blank: true

	validates_with Yesnovalidator
	belongs_to :project

	# has_many :projects, through: :join_model
	# has_and_belongs_to_many :projects
	after_create :add_to_timeline
	#only create not update, after_save: both create and update
	before_save :strip_spaces_from_tags
	private

	def add_to_timeline
		Timeline.create!({ content: "An issue was created!", timelineable_id: id, timelineable_type: self.class.to_s })
	end
	def strip_spaces_from_tags
		self.tags.gsub! ", ", ","
	end
end

