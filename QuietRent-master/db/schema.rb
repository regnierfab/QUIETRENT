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

ActiveRecord::Schema.define(version: 20170724182707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "comparaisons", force: :cascade do |t|
    t.integer  "edp_loyerf"
    t.integer  "edp_loyerl"
    t.string   "edp_situation_familialef"
    t.string   "edp_situation_familialel"
    t.integer  "edp_revenus_mensuelsf"
    t.integer  "edp_revenus_mensuelsl"
    t.string   "edp_year_birthf"
    t.string   "edp_year_birthl"
    t.string   "edp_contrat_travailf"
    t.string   "edp_contrat_travaill"
    t.string   "edp_cityf"
    t.string   "edp_cityl"
    t.integer  "user_id"
    t.string   "result_edpf"
    t.string   "result_edpl"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_comparaisons_on_user_id", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.string   "free_trial_length"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "edp_loyer"
    t.string   "edp_situation_familiale"
    t.integer  "edp_revenus_mensuels"
    t.string   "edp_year_birth"
    t.string   "edp_contrat_travail"
    t.string   "edp_city"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.string   "result_edp"
    t.index ["user_id"], name: "index_evaluations_on_user_id", using: :btree
  end

  create_table "fiabilites", force: :cascade do |t|
    t.integer  "fiabilite_parc"
    t.integer  "user_id"
    t.date     "date_fiabilite"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_fiabilites_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "locataires", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "fiabilite_pers"
    t.string   "sinistralite_pers"
    t.integer  "montant_loyer"
    t.integer  "revenus"
    t.string   "situation_pro"
    t.string   "situation_fam"
    t.string   "age_birth"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.string   "address"
    t.string   "street"
    t.string   "zip_code"
    t.string   "city"
    t.string   "email"
    t.index ["user_id"], name: "index_locataires_on_user_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "stripe_id"
    t.float    "price"
    t.string   "interval"
    t.text     "features"
    t.boolean  "highlight"
    t.integer  "display_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.string   "motif_prejudice"
    t.integer  "montant_prejudice"
    t.integer  "montant_reduction"
    t.string   "paiement_sur"
    t.date     "paiement_le"
    t.string   "nombre_paiement"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "locataire_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "sinistre_id"
    t.string   "status"
    t.text     "commentaire_loc"
    t.index ["locataire_id"], name: "index_resolutions_on_locataire_id", using: :btree
    t.index ["sinistre_id"], name: "index_resolutions_on_sinistre_id", using: :btree
    t.index ["user_id"], name: "index_resolutions_on_user_id", using: :btree
  end

  create_table "sinistres", force: :cascade do |t|
    t.string   "category"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "status",       default: "En cours"
    t.integer  "locataire_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description"
    t.index ["locataire_id"], name: "index_sinistres_on_locataire_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "stripe_id"
    t.integer  "plan_id"
    t.string   "last_four"
    t.integer  "coupon_id"
    t.string   "card_type"
    t.float    "current_price"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "profil"
    t.string   "number"
    t.boolean  "lot"
    t.string   "denomination"
    t.string   "address"
    t.string   "import"
    t.string   "import_sinistralite"
    t.integer  "fiabilite_parc"
    t.string   "sinistralite_parc"
    t.boolean  "admin",                             default: false, null: false
    t.string   "authentication_token",   limit: 50
    t.string   "slug"
    t.string   "visitor",                           default: [],                 array: true
    t.string   "role"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comparaisons", "users"
  add_foreign_key "evaluations", "users"
  add_foreign_key "fiabilites", "users"
  add_foreign_key "locataires", "users"
  add_foreign_key "resolutions", "locataires"
  add_foreign_key "resolutions", "sinistres"
  add_foreign_key "resolutions", "users"
  add_foreign_key "sinistres", "locataires"
end
