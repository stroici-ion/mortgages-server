class FormProgress < ApplicationRecord
  has_one :loans 

  enum :active_step, 
  action_type_step: 0,
  location_step: 1,
  property_type_step: 2,
  price_step: 3,
  user_situation_step: 4,
  targets_step: 5,
  date_step: 6,
  gift_funds_step: 7

  validates :active_step, presence: true

  before_save :check_form_completed


  private

  def check_form_completed
    self.form_completed = [
      action_type_completed,
      location_completed,
      property_type_completed,
      price_completed,
      about_user_completed,
      date_completed,
      targets_completed,
      gift_funds_completed
    ].all? { |completed| completed == true }
  end
end
