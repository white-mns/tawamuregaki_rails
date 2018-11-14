class AddIndexToPage < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, [:battle_no, :result_no, :generate_no], :unique => false, :name => 'unique_eno'
    add_index :pages, :story_id
    add_index :pages, :page_no
    add_index :pages, :party_num
    add_index :pages, :enemy_num
    add_index :pages, :battle_result
  end
end
