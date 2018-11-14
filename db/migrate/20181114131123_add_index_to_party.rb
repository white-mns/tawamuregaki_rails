class AddIndexToParty < ActiveRecord::Migration[5.2]
  def change
    add_index :parties, [:battle_no, :e_no, :result_no, :generate_no], :unique => false, :name => 'battle_no_eno'
    add_index :parties, :party_order
  end
end
