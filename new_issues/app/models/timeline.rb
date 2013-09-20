class Timeline < ActiveRecord::Base
  belongs_to :timelineable, polymorphic: true
end
