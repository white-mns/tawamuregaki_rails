class Page < ApplicationRecord
	belongs_to :story, :foreign_key => :story_id, :primary_key => :story_no, :class_name => 'StoryDatum'
	has_many :party_members, -> {order('party_order ASC')}, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many :enemy_members, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Enemy'
	belongs_to :leader,         -> { where(party_order: 0)},    :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many   :fellow_members, -> { where(party_order: 1..4)}, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'

    scope :pc_name_search, -> (params_members, params_leader, params_fellows) {
      members_query	= Party.search(params_members[:q]).result.select(:battle_no)
      leader_query	= Party.search(params_leader[:q]).result.select(:battle_no)
      fellows_query	= Party.search(params_fellows[:q]).result.select(:battle_no)
      where(battle_no: members_query).where(battle_no: leader_query).where(battle_no: fellows_query)
    }

end
