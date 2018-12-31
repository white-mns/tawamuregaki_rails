class Page < ApplicationRecord
	belongs_to :story,                                          :foreign_key => :story_id,  :primary_key => :story_no, :class_name => 'StoryDatum'
	has_many   :party_members,  -> {order('party_order ASC')},  :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many   :enemy_members,                                  :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Enemy'
	belongs_to :leader,         -> { where(party_order: 0)},    :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many   :fellow_members, -> { where(party_order: 1..4)}, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'

    scope :all_includes, -> (params) {
        includes(:story, [party_members: :pc_name]).
        leader_fellow_includes(params).
        enemy_includes(params)
    }
    
    scope :leader_fellow_includes, -> (params) {
        if params["show_leader_fellow"] == "1" then includes([leader: :pc_name], [fellow_members: :pc_name]) end
    }

    scope :enemy_includes, -> (params) {
        if params["show_enemy"] == "1" then includes([enemy_members: [:enemy, :suffix]]) end
    }

    scope :where_members, -> (params) {
        if params["party_members_e_no_form"] || params["party_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

    scope :where_leader, -> (params) {
        if params["leader_e_no_form"] || params["leader_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

    scope :where_fellows, -> (params) {
        if params["fellow_members_e_no_form"] || params["fellow_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

end
