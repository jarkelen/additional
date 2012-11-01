# == Schema Information
#
# Table name: ins_insurances
#
#  id                               :integer         not null, primary key
#  insurance_nr                     :string(255)
#  branch  			                    :string(255)
#  insurance_type                   :string(255)
#  market                           :string(255)
#  start_date                       :datetime
#  duration                         :integer
#  first_contract_expiration_date   :datetime
#  main_premium_expiration_date     :datetime
#  extension                        :string(255)
#  payment_continuation             :string(255)
#  arrear_calculation               :boolean
#  attachment_1				              :string(255)
#  attachment_2				              :string(255)
#  attachment_3				              :string(255)
#  relation_id                      :integer
#  company_id                       :integer
#
class InsInsurance < ActiveRecord::Base
	belongs_to :relation
	belongs_to :company

	attr_accessible :insurance_nr, :branch, :insurance_type, :market, :start_date, :duration,
									:first_contract_expiration_date, :main_premium_expiration_date,
									:extension, :payment_continuation, :arrear_calculation, :attachment_1,
									:attachment_2, :attachment_3, :relation_id, :company_id

	# Add attachment uploader
	mount_uploader :attachment_1, InsuranceUploader
	mount_uploader :attachment_2, InsuranceUploader
	mount_uploader :attachment_2, InsuranceUploader

	validates       :insurance_nr, :branch, :insurance_type, :market, :start_date, :duration, 
									:first_contract_expiration_date, :main_premium_expiration_date, 
									:extension, :payment_continuation, :relation_id, :company_id, 
									presence: true

  #------------------------------- CLASS METHODS -------------------------------

  # Get filtered insurances
  def self.filter(params)
    conditions = { }

    # Filter on insurance number
    unless params[:insurance_nr].blank?
      conditions[:insurance_nr] = params[:insurance_nr]
    end

    # Filter on relation
    unless params[:relation_id].blank?
      conditions[:relation_id] = params[:relation_id]
    end

    # Filter on branch
    unless params[:branch].blank?
      conditions[:branch] = params[:branch]
    end

    # Filter on type
    unless params[:insurance_type].blank?
      conditions[:insurance_type] = params[:insurance_type]
    end

    # Filter on market
    unless params[:market].blank?
      conditions[:market] = params[:market]
    end

    # Filter on expiration date
    unless params[:expiration_date].blank?
      conditions[:main_premium_expiration_date] = params[:expiration_date]
    end

    # Find filtered relations
    order("insurance_nr ASC").where(conditions)
  end

  #------------------------------- INSTANCE METHODS -------------------------------

	def date_for_select
		main_premium_expiration_date.strftime("%d-%m")
	end


end