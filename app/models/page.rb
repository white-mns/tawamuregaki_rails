class Page < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :story, :foreign_key => :story_id, :primary_key => :story_no, :class_name => 'StoryDatum'
	has_many :party_members, -> {order('party_order ASC')}, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many :enemy_members, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Enemy'
	belongs_to :leader,         -> { where(party_order: 0)},    :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'
	has_many   :fellow_members, -> { where(party_order: 1..4)}, :foreign_key => :battle_no, :primary_key => :battle_no, :class_name => 'Party'

    scope :where_members, -> (params) {
        if params["party_members_e_no_form"] || params["party_members_name_form"] then
            query = Party.includes(:pc_name).ransack(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

    scope :where_leader, -> (params) {
        if params["leader_e_no_form"] || params["leader_name_form"] then
            query = Party.includes(:pc_name).ransack(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

    scope :where_fellows, -> (params) {
        if params["fellow_members_e_no_form"] || params["fellow_members_name_form"] then
            query = Party.includes(:pc_name).ransack(params[:q]).result.select(:battle_no)
            where(battle_no: query)
        end
    }

end
