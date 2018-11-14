class Enemy < ApplicationRecord
	belongs_to :enemy,  :foreign_key => :enemy_id,  :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :suffix, :foreign_key => :suffix_id, :primary_key => :proper_id, :class_name => 'ProperName'
end
