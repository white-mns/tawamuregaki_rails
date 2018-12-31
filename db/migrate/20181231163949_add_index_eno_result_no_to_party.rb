class AddIndexEnoResultNoToParty < ActiveRecord::Migration[5.2]
  def change
    add_index :parties, [:e_no, :result_no, :generate_no], :unique => false, :name => 'eno_resultno'
  end
end
