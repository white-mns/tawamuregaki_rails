class AddIndexResultNoBattleResultToPage < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, [:result_no, :battle_result], :unique => false, :name => 'resultno_battleresult'
  end
end
