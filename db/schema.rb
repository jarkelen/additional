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

#ActiveRecord::Schema.define(:version => 20120710111906) do
ActiveRecord::Schema.define(:version => 20120712104646) do

  create_table "activities", :force => true do |t|
    t.string   "activity"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "agreements", :force => true do |t|
    t.string   "agreement"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dossier_id"
  end

  create_table "alerts", :force => true do |t|
    t.string   "alert_text"
    t.string   "detail_link"
    t.string   "area"
    t.integer  "area_id"
    t.boolean  "dismiss"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", :force => true do |t|
    t.string   "branch"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "mod_timesheet",   :default => false
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "dec_categories", :force => true do |t|
    t.string   "category"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dec_declarationlines", :force => true do |t|
    t.datetime "declaration_date"
    t.string   "category"
    t.string   "description"
    t.decimal  "amount"
    t.integer  "dec_declaration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dec_declarationlines", ["dec_declaration_id"], :name => "index_dec_declarationlines_on_dec_declaration_id"

  create_table "dec_declarations", :force => true do |t|
    t.string   "declaration_nr"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_sent"
    t.datetime "date_approved"
    t.datetime "date_corrected"
  end

  add_index "dec_declarations", ["user_id"], :name => "index_dec_declarations_on_user_id"

  create_table "dossier_statuses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "status"
  end

  create_table "dossiers", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "budget"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "fte"
    t.integer  "company_id"
  end

  create_table "ins_branches", :force => true do |t|
    t.string   "branch"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "arrear_calculation",             :limit => 255
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "attachment_1"
    t.string   "attachment_2"
    t.string   "attachment_3"
  end

  create_table "ins_markets", :force => true do |t|
    t.string   "market"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ins_markets", ["company_id"], :name => "index_modules_insurance_markets_on_company_id"

  create_table "ins_types", :force => true do |t|
    t.string   "ins_type"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ins_branch_id"
  end

  add_index "ins_types", ["company_id"], :name => "index_modules_insurance_types_on_company_id"
  add_index "ins_types", ["ins_branch_id"], :name => "index_modules_insurance_types_on_branch_id"

  create_table "inv_categories", :force => true do |t|
    t.string   "description"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "inv_histories", :force => true do |t|
    t.integer  "inv_invoice_id"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inv_invoicelines", :force => true do |t|
    t.integer  "inv_invoice_id"
    t.string   "description"
    t.integer  "nr_items"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "tax"
    t.decimal  "total"
  end

  create_table "inv_invoices", :force => true do |t|
    t.string   "title"
    t.integer  "relation_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.string   "status"
    t.string   "invoice_type"
    t.datetime "invoice_date"
    t.datetime "expiration_date"
    t.datetime "payment_date"
    t.string   "introtext"
    t.string   "extratext"
    t.string   "category"
    t.string   "payment_condition"
    t.boolean  "recurring"
    t.string   "recurring_frequency"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "invoice_nr"
  end

  create_table "inv_paymentconditions", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "inv_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_nl"
    t.string   "status_en"
    t.integer  "company_id"
  end

  create_table "inv_taxes", :force => true do |t|
    t.string   "description"
    t.integer  "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "mob_cars", :force => true do |t|
    t.string   "brand"
    t.string   "brand_type"
    t.string   "license_plate"
    t.integer  "price"
    t.decimal  "company_contribution"
    t.decimal  "employee_contribution"
    t.integer  "start_km"
    t.integer  "end_km"
    t.datetime "start_date"
    t.datetime "cancel_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lease_company"
    t.integer  "contract_duration"
    t.string   "fuel_type"
  end

  add_index "mob_cars", ["user_id"], :name => "index_mob_cars_on_user_id"

  create_table "mob_endofyears", :force => true do |t|
    t.datetime "year"
    t.integer  "mileage"
    t.integer  "mob_car_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mob_endofyears", ["mob_car_id"], :name => "index_mob_endofyears_on_mob_car_id"

  create_table "mpl_bids", :force => true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.float    "bid_tariff"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mpl_offer_id"
  end

  create_table "mpl_marketplaces", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "mpl_offerinvites", :force => true do |t|
    t.integer  "mpl_offer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mpl_offers", :force => true do |t|
    t.integer  "mpl_marketplace_id"
    t.string   "name"
    t.string   "expertise"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "relation_id"
    t.boolean  "extension"
    t.string   "level"
    t.float    "offer_tariff"
    t.string   "workplace"
    t.text     "remarks"
    t.float    "agreed_tariff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "intake"
    t.datetime "deadline"
    t.string   "status"
    t.integer  "agreed_subco"
  end

  create_table "notes", :force => true do |t|
    t.string   "note_type"
    t.string   "subject"
    t.text     "note"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment"
    t.integer  "dossier_id"
    t.string   "url"
  end

  create_table "rel_types", :force => true do |t|
    t.string   "rel_type"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relations", :force => true do |t|
    t.string   "name"
    t.integer  "company_contact", :limit => 255
    t.string   "website"
    t.integer  "kvk_nr"
    t.string   "industry"
    t.string   "legal"
    t.string   "nr_employees"
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "relation_nr"
    t.string   "relationgroup"
  end

  create_table "sectors", :force => true do |t|
    t.string   "sector"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.integer  "discount"
    t.datetime "start_date"
    t.string   "billing_period"
    t.float    "user_price"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.boolean  "mod_timesheet",  :default => false
    t.boolean  "mod_mobility",   :default => false
    t.boolean  "mod_employee",   :default => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "task_type"
    t.string   "task"
    t.datetime "due_at"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dossier_id"
  end

  create_table "tasktypes", :force => true do |t|
    t.string   "tasktype"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tms_defaulthours", :force => true do |t|
    t.integer  "tms_unbillable_id"
    t.string   "location"
    t.decimal  "hours_billable"
    t.decimal  "hours_unbillable"
    t.integer  "km"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tms_project_id"
  end

  add_index "tms_defaulthours", ["user_id"], :name => "index_tms_defaulthours_on_user_id"

  create_table "tms_departments", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tms_departments", ["company_id"], :name => "index_tms_departments_on_company_id"

  create_table "tms_periods", :force => true do |t|
    t.integer  "period_nr"
    t.string   "period_short"
    t.string   "period_long"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tms_periods", ["company_id"], :name => "index_tms_periods_on_company_id"

  create_table "tms_project_users", :force => true do |t|
    t.integer  "tms_project_id"
    t.integer  "user_id"
    t.decimal  "tariff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tms_project_users", ["tms_project_id"], :name => "index_tms_project_users_on_tms_project_id"
  add_index "tms_project_users", ["user_id"], :name => "index_tms_project_users_on_user_id"

  create_table "tms_projects", :force => true do |t|
    t.string   "project_name"
    t.string   "project_type"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "tms_projects", ["relation_id"], :name => "index_tms_projects_on_relation_id"

  create_table "tms_publicholidays", :force => true do |t|
    t.datetime "holiday_date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "tms_period_id"
  end

  create_table "tms_timesheetlines", :force => true do |t|
    t.integer  "daynr"
    t.integer  "tms_unbillable_id"
    t.string   "location"
    t.decimal  "hours_billable"
    t.decimal  "hours_unbillable"
    t.integer  "km"
    t.string   "comment"
    t.integer  "tms_timesheet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tms_project_id"
  end

  create_table "tms_timesheets", :force => true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tms_period_id"
    t.string   "timesheet_nr"
  end

  add_index "tms_timesheets", ["user_id"], :name => "index_tms_timesheets_on_tms_period_id_and_user_id"

  create_table "tms_unbillables", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tms_unbillables", ["company_id"], :name => "index_tms_unbillables_on_company_id"

  create_table "user_emps", :force => true do |t|
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.string   "telephone_business"
    t.string   "telephone_private"
    t.string   "telephone_mobile"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.datetime "birth_date"
    t.string   "marital_status"
    t.integer  "kids"
    t.string   "interests"
    t.string   "bio"
    t.string   "kids_names"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "website"
    t.string   "photo_url"
  end

  create_table "user_mobs", :force => true do |t|
    t.string   "car_type"
    t.integer  "private_km"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_tms", :force => true do |t|
    t.boolean  "internal"
    t.integer  "department",   :limit => 255
    t.integer  "manager"
    t.decimal  "holiday"
    t.datetime "start_period"
    t.datetime "leave_period"
    t.decimal  "bonus_from"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :default => "",    :null => false
    t.integer  "sign_in_count",   :default => 0
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "department"
    t.integer  "company_id"
    t.string   "password_digest"
    t.string   "role"
    t.string   "middle_name"
    t.string   "locale"
    t.boolean  "mod_marketplace"
    t.boolean  "mod_employee"
    t.boolean  "mod_platform",    :default => true
    t.boolean  "mod_invoice"
    t.boolean  "mod_insurance"
    t.boolean  "mod_timesheet",   :default => false
    t.boolean  "mod_declaration"
    t.boolean  "mod_mobility",    :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
