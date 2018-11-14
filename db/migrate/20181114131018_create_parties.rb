class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_no
      t.integer :e_no
      t.integer :party_order

      t.timestamps
    end
  end
end
