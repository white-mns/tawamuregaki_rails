class Page < ApplicationRecord
	belongs_to :story, :foreign_key => :story_id, :primary_key => :story_no, :class_name => 'StoryDatum'
	has_many :party_members, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many :enemy_members, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Enemy'
end
