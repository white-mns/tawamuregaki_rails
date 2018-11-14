class AddIndexToStoryData < ActiveRecord::Migration[5.2]
  def change
    add_index :story_data, :story_no
    add_index :story_data, :title
    add_index :story_data, :max_page
  end
end
