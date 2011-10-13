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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111013182214) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.boolean  "featured"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unique_event_id"
    t.text     "description"
    t.string   "image_url"
    t.string   "ticket_info"
    t.string   "ticket_prices"
    t.string   "additional_info"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
  end

  add_index "events", ["unique_event_id"], :name => "index_events_on_unique_event_id", :unique => true

  create_table "events_groups", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "group_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "group_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
