class LoanCreateUpdateSerializer  < ActiveModel::Serializer
  attributes :id, :action_type, :country, :address, :zip_code, :latitude, :longitude, 
  :property_type, :price, :down_payment_rate, :user_situation, :date, 
  :duration, :rate, :gift_funds, :form_completed, :active_step


  def date
    object.created_at.strftime("%B %d, %Y")
  end

  def form_completed
    object.form_progress&.form_completed
  end

  def active_step
    object.form_progress&.active_step
  end

  def action_type
    object.action_type_before_type_cast
  end

  def property_type
    object.property_type_before_type_cast
  end

  def user_situation
    object.user_situation_before_type_cast
  end
end

