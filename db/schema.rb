# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_14_121103) do

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no", "result_no", "generate_no"], name: "unique_eno"
    t.index ["name"], name: "index_names_on_name"
    t.index ["nickname"], name: "index_names_on_nickname"
  end

  create_table "pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_no"
    t.integer "story_id"
    t.integer "page_no"
    t.integer "party_num"
    t.integer "enemy_num"
    t.integer "battle_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_no", "result_no", "generate_no"], name: "unique_eno"
    t.index ["battle_result"], name: "index_pages_on_battle_result"
    t.index ["enemy_num"], name: "index_pages_on_enemy_num"
    t.index ["page_no"], name: "index_pages_on_page_no"
    t.index ["party_num"], name: "index_pages_on_party_num"
    t.index ["story_id"], name: "index_pages_on_story_id"
  end

  create_table "proper_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "story_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "story_no"
    t.string "title"
    t.integer "max_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["max_page"], name: "index_story_data_on_max_page"
    t.index ["story_no"], name: "index_story_data_on_story_no"
    t.index ["title"], name: "index_story_data_on_title"
  end

end
