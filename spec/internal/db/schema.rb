# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140730092901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ilohv_nodes", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "full_path"
    t.string   "file"
    t.text     "meta_data"
    t.text     "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ilohv_nodes", ["ancestry"], name: "index_ilohv_nodes_on_ancestry", using: :btree
  add_index "ilohv_nodes", ["full_path"], name: "index_ilohv_nodes_on_full_path", using: :btree
  add_index "ilohv_nodes", ["name"], name: "index_ilohv_nodes_on_name", using: :btree

end
