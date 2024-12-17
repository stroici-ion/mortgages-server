FactoryBot.define do
  factory :loan do
    action_type { 1 }
    country { "Moldova" }
    address { "Example street 12/2" }
    zip_code { "12345" }
    latitude { 45.0 }
    longitude { 25.0 }
    property_type { 1 }
    price { 200000 }
    down_payment_rate { 10 }
    down_payment { 20000 }
    user_situation { 1 }
    date { "2024-12-17" }
    duration { 30 }
    rate { 5 }
    gift_funds { 10000 }

    association :form_progress, factory: :form_progress

    trait :with_form_progress do
      form_progress { create(:form_progress) }
    end
  end
end
