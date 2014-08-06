ActiveRecord::Schema.define(version: 20140730092901) do
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
