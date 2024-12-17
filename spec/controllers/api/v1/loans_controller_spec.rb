require 'rails_helper'

RSpec.describe Api::V1::LoansController, type: :controller do
  let!(:completed_loan) { create(:loan, :with_form_progress) }
  let!(:incompleted_loan) { create(:loan, :with_form_progress) }


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
  
  before do
    completed_loan.form_progress.update(
      action_type_completed: true, 
      location_completed: true, 
      property_type_completed: true, 
      price_completed: true, 
      about_user_completed: true, 
      date_completed: true, 
      targets_completed: true, 
      gift_funds_completed: true
    )
    incompleted_loan.form_progress.update(   
      action_type_completed: false, # at least one step to ne incompleted and form_completed becomes false
    )
  end

  describe "GET #index" do
    it "retuen status 200 and the list of completed loans" do
      get :index
      expect(response).to have_http_status(:ok)
      loans = JSON.parse(response.body)["loans"]
      expect(loans.length).to eq(1)
      expect(loans.first["id"]).to eq(completed_loan.id)
    end

    it "includes a incompleted loan form if exists" do
      get :index
      response_data = JSON.parse(response.body)
      expect(response_data).to have_key("incompleted_loan_form")
      expect(response_data["incompleted_loan_form"]["id"]).to eq(incompleted_loan.id)
    end

    it "does not include a incompleted loan form if it does not exist" do
      incompleted_loan.form_progress.update(
          action_type_completed: true, 
          location_completed: true, 
          property_type_completed: true, 
          price_completed: true, 
          about_user_completed: true, 
          date_completed: true, 
          targets_completed: true, 
          gift_funds_completed: true
        ) #
      get :index
      response_data = JSON.parse(response.body)
      expect(response_data).not_to have_key("incompleted_loan_form")
    end
  end

  describe "POST #create" do
    context "when an incomplete loan form exists" do
      it "returns an error response with status 409" do
        post :create, params: valid_params
        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)["error"]).to eq("Loan already exists")
      end
    end

    context "when an incomplete loan form do not exists" do
      before do
        incompleted_loan.form_progress.update(
          action_type_completed: true, 
          location_completed: true, 
          property_type_completed: true, 
          price_completed: true, 
          about_user_completed: true, 
          date_completed: true, 
          targets_completed: true, 
          gift_funds_completed: true
        )
      end

      it "creates a loan with success" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include("id", "action_type", "price")
      end

      it "returns an error response if the data is invalid" do
        invalid_params = valid_params.deep_merge(loan: { price: 0 })
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["price"]).to include("must be greater than 0")
      end
    end
  end

  let(:loan) { create(:loan, :with_form_progress) }
  let(:valid_params) do
    {
      loan: {
        down_payment_rate: 10,
        price: 150000
      },
      form_progress: { active_step: "price_step" }
    }
  end

  describe "PUT #update" do
    context "when the update is valid" do
      it "return updated loan" do
        put :update, params: { id: loan.id }.merge(valid_params)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["price"]).to eq("150000.0")
        expect(JSON.parse(response.body)["down_payment_rate"]).to eq("10.0")
      end
    end

    context "when the update is invalid" do
      it "returns validation errors" do
        invalid_params = valid_params.deep_merge(loan: { down_payment_rate: 0 })
        put :update, params: { id: loan.id }.merge(invalid_params)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["down_payment_rate"]).to include("must be greater than or equal to 10 and less than or equal to 100")
      end
    end
  end

  let(:loan) { create(:loan, :with_form_progress) }

  describe "GET #show" do
    context "when loan exists" do
      it "returns status 200 and loan data" do
        get :show, params: { id: loan.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(loan.id)
      end
    end

    context "when the loan does not exist" do
      it "returns status 404" do
        get :show, params: { id: 99999 } # invalid id
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
