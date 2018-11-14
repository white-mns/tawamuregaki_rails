class AddIndexToEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :enemies, [:battle_no, :result_no, :generate_no], :unique => false, :name => 'battle_no_eno'
    add_index :enemies, :enemy_id
    add_index :enemies, :suffix_id
  end
end
