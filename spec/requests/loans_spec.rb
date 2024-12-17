require 'rails_helper'

RSpec.describe "Loans", type: :request do

  let(:valid_params) do
    {
      loan: {
        action_type: "buy_a_new_home",  
        down_payment: 20000,
        country: "Moldova",
        address: "Example street 12/2",
        latitude: 45.0,
        longitude: 25.0,
        zip_code: "12345", 
        property_type: "single_family_home",  
        price: 200000,
        down_payment_rate: 10, 
        user_situation: "practicing_hospitalitist",  
        date: "2024-12-17", 
        duration: 30,
        rate: 5,
        gift_funds: 900
      },
      form_progress: { active_step: "action_type_step" } 
    }
  end

  let(:valid_params_to_update) do 
    {
      loan: {
   
        country: "USA",
        address: "Example street 24/2",
        zip_code: "54321"
      },
      form_progress: { active_step: "location_step" } 
    }
  end

  let(:invalid_params) do
    {
      loan: {
        price: 0,
      },
      form_progress: { active_step: "location_step" } 
    }
  end

  describe "GET /index" do
    it "returns a successful response" do
      get api_v1_loans_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Loan" do
        expect {
          post api_v1_loans_path, params: valid_params
        }.to change(Loan, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Loan" do
        expect {
          post api_v1_loans_path, params: invalid_params
        }.to change(Loan, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "GET /show" do
    it "returns a successful response" do
      loan_to_show = Loan.first
      get api_v1_loans_path(loan_to_show) 
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    let!(:loan_to_update) do
      Loan.create!(
        country: "Moldova",
        address: "Example street 12/2",
        zip_code: "12345",
        action_type: "buy_a_new_home",
        property_type: 1,
        price: 200000,
        down_payment_rate: 10,
        user_situation: "exciting",
        date: "2024-12-17",
        duration: 30,
        rate: 5,
        gift_funds: 900,
        form_progress: FormProgress.create!(active_step: 1, form_completed: false)
      )
    end

    context "with valid parameters" do
      it "updates the requested loan" do
        patch api_v1_loan_path(loan_to_update), params: valid_params_to_update
        loan_to_update.reload
        expect(loan_to_update.country).to eq("USA")
        expect(loan_to_update.address).to eq("Example street 24/2")
        expect(loan_to_update.zip_code).to eq("54321")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "does not update the loan" do
        patch api_v1_loan_path(loan_to_update), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
