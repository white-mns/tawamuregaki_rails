class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_no
      t.integer :story_id
      t.integer :page_no
      t.integer :party_num
      t.integer :enemy_num
      t.integer :battle_result

      t.timestamps
    end
  end
end
