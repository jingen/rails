class Whatever
    include Mongoid::Document
	belongs_to :timelineable, polymorphic: true
end
