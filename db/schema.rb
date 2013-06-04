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

ActiveRecord::Schema.define(:version => 20130604140023) do

  create_table "activities", :force => true do |t|
    t.string   "activity"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "agreements", :force => true do |t|
    t.string   "agreement"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "dossier_id"
  end

  create_table "branches", :force => true do |t|
    t.string   "branch"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sector_id"
    t.integer  "company_id"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "telephone"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "bucket"
    t.string   "website"
    t.integer  "kvk_nr"
    t.string   "bankaccount"
    t.string   "billing_address"
    t.string   "billing_zipcode"
    t.string   "billing_city"
    t.string   "billing_country"
    t.string   "post_address"
    t.string   "post_zipcode"
    t.string   "post_city"
    t.string   "post_country"
    t.string   "tax_nr"
    t.string   "logo"
  end

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "function"
    t.string   "telephone_business"
    t.string   "telephone_private"
    t.string   "telephone_mobile"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.text     "background"
    t.integer  "relation_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "email"
    t.string   "middle_name"
    t.string   "salutation"
    t.string   "gender"
    t.string   "title"
    t.date     "birth_date"
    t.string   "fax"
    t.string   "custom_label_1"
    t.string   "custom_field_1"
    t.string   "custom_label_2"
    t.string   "custom_field_2"
    t.string   "custom_label_3"
    t.string   "custom_field_3"
    t.integer  "has_boss"
  end

  create_table "contacts_dossiers", :id => false, :force => true do |t|
    t.integer "dossier_id"
    t.integer "contact_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "dossier_statuses", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  create_table "dossiers", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "budget"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "dossiers_contacts", :id => false, :force => true do |t|
    t.integer "dossier_id"
    t.integer "contact_id"
  end

  create_table "ins_branches", :force => true do |t|
    t.string   "branch"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ins_branches", ["company_id"], :name => "index_modules_insurance_branches_on_company_id"

  create_table "ins_insurances", :force => true do |t|
    t.string   "insurance_nr"
    t.string   "branch"
    t.string   "insurance_type"
    t.string   "market"
    t.datetime "start_date"
    t.integer  "duration"
    t.datetime "first_contract_expiration_date"
    t.datetime "main_premium_expiration_date"
    t.string   "extension"
    t.string   "payment_continuation"
    t.text     "arrear_calculation"
    t.integer  "relation_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "company_id"
    t.string   "attachment_1"
    t.string   "attachment_2"
    t.string   "attachment_3"
    t.string   "attachment_4"
    t.string   "status",                         :default => "actief"
    t.datetime "end_date"
  end

  add_index "ins_insurances", ["company_id"], :name => "index_modules_insurance_insurances_on_company_id"
  add_index "ins_insurances", ["relation_id"], :name => "index_modules_insurance_insurances_on_relation_id"

  create_table "ins_markets", :force => true do |t|
    t.string   "market"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ins_markets", ["company_id"], :name => "index_modules_insurance_markets_on_company_id"

  create_table "ins_types", :force => true do |t|
    t.string   "ins_type"
    t.integer  "company_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "ins_branch_id"
  end

  add_index "ins_types", ["company_id"], :name => "index_modules_insurance_types_on_company_id"
  add_index "ins_types", ["ins_branch_id"], :name => "index_modules_insurance_types_on_branch_id"

  create_table "notes", :force => true do |t|
    t.string   "note_type"
    t.string   "subject"
    t.text     "note"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "attachment"
    t.integer  "dossier_id"
    t.string   "url"
  end

  create_table "rel_types", :force => true do |t|
    t.string   "rel_type"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relations", :force => true do |t|
    t.string   "relation_nr"
    t.string   "name"
    t.string   "company_contact"
    t.string   "website"
    t.integer  "kvk_nr"
    t.string   "industry"
    t.string   "legal"
    t.string   "nr_employees",    :limit => 25
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "billing_address"
    t.string   "billing_zipcode"
    t.string   "billing_city"
    t.string   "billing_country"
    t.string   "visit_address"
    t.string   "visit_zipcode"
    t.string   "visit_city"
    t.string   "visit_country"
    t.text     "remarks"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "relation_type"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "status"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "logo"
    t.integer  "company_id"
    t.string   "branch"
    t.string   "bankaccount"
    t.string   "post_address"
    t.string   "post_zipcode"
    t.string   "post_city"
    t.string   "post_country"
    t.string   "custom_label_1"
    t.string   "custom_field_1"
    t.string   "custom_label_2"
    t.string   "custom_field_2"
    t.string   "custom_label_3"
    t.string   "custom_field_3"
    t.string   "relationgroup"
  end

  create_table "sectors", :force => true do |t|
    t.string   "sector"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "pincode"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.integer  "discount"
    t.datetime "start_date"
    t.string   "billing_period"
    t.float    "user_price"
    t.boolean  "active"
    t.boolean  "mod_time"
    t.boolean  "mod_contract"
    t.boolean  "mod_invoice"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "company_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "task_type"
    t.string   "task"
    t.datetime "due_at"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "dossier_id"
  end

  create_table "tasktypes", :force => true do |t|
    t.string   "tasktype"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "updates", :force => true do |t|
    t.string   "update"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.integer  "sign_in_count"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.datetime "last_sign_in_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "department"
    t.integer  "company_id"
    t.string   "password_digest"
    t.string   "role"
    t.string   "middle_name"
    t.string   "locale"
    t.boolean  "mod_platform",    :default => true
    t.boolean  "mod_insurance"
  end

end
