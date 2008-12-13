# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 9) do

  create_table "belongings", :force => true do |t|
    t.string   "name"
    t.integer  "page_id"
    t.integer  "position"
    t.string   "widget_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bpacks", :force => true do |t|
    t.string   "fullname"
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", :force => true do |t|
    t.string   "file_name"
    t.string   "description"
    t.integer  "belonging_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "list_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "completed"
  end

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.integer  "belonging_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.integer  "belonging_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.integer  "bpack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "separators", :force => true do |t|
    t.string   "title"
    t.integer  "belonging_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.integer  "belonging_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
