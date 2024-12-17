class LoanShowSerializer  < ActiveModel::Serializer
  attributes :id, :action_type, :country, :address, :zip_code, :latitude, :longitude, 
  :property_type, :price, :down_payment_rate, :user_situation, :date, 
  :duration, :monthly_payment, :rate, :reverse_amount, :gift_funds, :is_document_reviewed, 
  :is_pending_final_approval, :is_approved

  def date
    object.created_at.strftime("%B %d, %Y")
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
