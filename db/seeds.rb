
form_progress_1 = FormProgress.create!(
  action_type_completed: true, 
  location_completed: true, 
  property_type_completed: true, 
  price_completed: true, 
  about_user_completed: true, 
  date_completed: true, 
  targets_completed: true, 
  gift_funds_completed: true,
  form_completed: true,
  active_step: "action_type_step"
)

form_progress_2 = FormProgress.create!(
  action_type_completed: true, 
  location_completed: true, 
  property_type_completed: true, 
  price_completed: true, 
  about_user_completed: true, 
  date_completed: true, 
  targets_completed: true, 
  gift_funds_completed: true,
  form_completed: true,
  active_step: "action_type_step"
)

Loan.create!(
  action_type: "buy_a_new_home",
  country: "Moldova",
  address: "Mihai Viteazu 12/2",
  latitude: 45.0,
  longitude: 25.0,
  zip_code: "12345", 
  property_type: "apartment",
  price: 200000,
  down_payment_rate: 10,
  user_situation: "self_employed_clinician",
  date: "2024-12-17", 
  duration: 30,
  rate: 5,
  gift_funds: 900,
  form_progress: form_progress_1
)

Loan.create!(
  action_type: "refinance_my_home_loan",
  country: "USA",
  address: "Alexei Sciusev 3",
  latitude: 40.0,
  longitude: -75.0,
  zip_code: "54321", 
  property_type: "town_home",
  price: 30000,
  down_payment_rate: 15,
  user_situation: "practicing_hospitalitist",
  date: "2024-12-18", 
  duration: 20,
  rate: 4.5,
  gift_funds: 1000,
  form_progress: form_progress_2
)
