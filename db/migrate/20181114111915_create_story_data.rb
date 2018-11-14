class CreateStoryData < ActiveRecord::Migration[5.2]
  def change
    create_table :story_data do |t|
      t.integer :story_no
      t.string :title
      t.integer :max_page

      t.timestamps
    end
  end
end
