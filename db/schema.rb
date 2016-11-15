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

ActiveRecord::Schema.define(version: 20161115175100) do

  create_table "movies", force: :cascade do |t|
    t.text     "title",             limit: 65535
    t.text     "also_known_as",     limit: 65535
    t.string   "url",               limit: 4083
    t.text     "company",           limit: 65535
    t.text     "countries",         limit: 65535
    t.text     "filming_locations", limit: 65535
    t.text     "genres",            limit: 65535
    t.text     "languages",         limit: 65535
    t.integer  "length",            limit: 4
    t.string   "mpaa_rating",       limit: 5
    t.text     "plot",              limit: 65535
    t.text     "plot_summary",      limit: 65535
    t.text     "plot_synopsis",     limit: 65535
    t.string   "poster",            limit: 4083
    t.float    "rating",            limit: 24
    t.datetime "release_date"
    t.text     "tagline",           limit: 65535
    t.string   "trailer_url",       limit: 4083
    t.integer  "votes",             limit: 4
    t.integer  "year",              limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "person_class", limit: 255
    t.string   "person_type",  limit: 255
    t.string   "country",      limit: 255
    t.string   "language",     limit: 255
    t.datetime "dob"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "persons_movies", force: :cascade do |t|
    t.integer  "person_id",         limit: 4
    t.integer  "movie_id",          limit: 4
    t.string   "relation_capacity", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "limit",      limit: 254
    t.integer  "age",        limit: 4
    t.string   "gender",     limit: 10
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
