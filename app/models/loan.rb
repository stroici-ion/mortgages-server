class Loan < ApplicationRecord
  belongs_to :form_progress

  before_save :update_monthly_payment, :update_reverse_amount

  validates :zip_code, format: { with: /\A\d{5}\z/, message: "must contain exactly 5 digits" }, allow_nil: true   
  validate :down_payment_rate_is_valid
  validate :price_is_positive

  enum :action_type, 
  buy_a_new_home: 0,
  refinance_my_home_loan: 1

  enum :property_type, 
  single_family_home: 0,
  town_home: 1,
  condominium: 2,
  apartment: 3,
  other: 4

  enum :user_situation, 
  practicing_hospitalitist: 0,
  exciting_fellowship: 1,
  exciting: 2,
  self_employed_clinician: 3


  def formatted_date
    date.strftime("%B %d, %Y")
  end

  def formatted_date=(value)
    self.date = Date.strptime(value, "%B %d, %Y")
  end

  private


  def down_payment_rate_is_valid
    if down_payment_rate.present? && (down_payment_rate < 10 || down_payment_rate > 100)
      errors.add(:down_payment_rate, "must be greater than or equal to 10 and less than or equal to 100")
    end
  end

  def price_is_positive
    if price.present? && price <= 0
      errors.add(:price, "must be greater than 0")
    end
  end
  
  def down_payment_rate_is_valid
    if down_payment_rate.present? && (down_payment_rate < 10 || down_payment_rate > 100)
      errors.add(:down_payment_rate, "must be greater than or equal to 10 and less than or equal to 100")
    end
  end


  def update_monthly_payment
    if price && rate && duration
      r = rate / 12 / 100
      n = duration * 12
      self.monthly_payment = (price * (r * (1 + r)**n) / ((1 + r)**n - 1)).round(2)
    end
  end

  def update_reverse_amount
    if price && rate && duration
      r = rate / 12 / 100
      n = duration * 12
      k = 13 # Ar trebui să adaugi un mecanism pentru a actualiza `k` pe baza plăților efectuate
      self.reverse_amount = (price * ((1 + r)**n - (1 + r)**k) / ((1 + r)**n - 1)).round(2)
    end
  end
end
