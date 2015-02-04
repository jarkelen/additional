# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


company = Company.create(name: "Demo Company", code: "DMO", email: "info@demo.nl", address1: "Lichtstraat 173", 
    address2: "", zipcode: "5611 XD", city: "Eindhoven", country: "Nederland")
User.create(first_name: "Arie", last_name: "Admin", role: "admin", email: "arie.admin@demo.nl", locale: "nl", 
    mod_platform: true, mod_insurance: true, mod_claim: false, company_id: company.id)
Tasktype.create(company_id: company.id, tasktype: "todo")