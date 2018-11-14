class Page < ApplicationRecord
	belongs_to :story, :foreign_key => :story_id, :primary_key => :story_no, :class_name => 'StoryDatum'
end
