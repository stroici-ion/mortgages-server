require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:form_progress) { create(:form_progress, active_step: 1) }



  subject(:loan) do
    described_class.new(
      form_progress: form_progress,
      zip_code: "12345",
      price: 500000,
      rate: 5,
      duration: 30,
      down_payment_rate: 20,
      date: Date.today,
      action_type: :buy_a_new_home,
      property_type: :single_family_home,
      user_situation: :practicing_hospitalitist
    )
  end

  it "is an instance of Loan" do
    loan = described_class.new
    expect(loan).to be_an_instance_of(described_class)
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(loan).to be_valid
    end

    it "validates zip_code format to be exactly 5 digits" do
      loan.zip_code = "1234" # invalid
      expect(loan).not_to be_valid
      expect(loan.errors[:zip_code]).to include("must contain exactly 5 digits")
    end

    it "allows nil zip_code" do
      loan.zip_code = nil
      expect(loan).to be_valid
    end

    it "validates down_payment_rate is within range 10-100" do
      loan.down_payment_rate = 5
      expect(loan).not_to be_valid
      expect(loan.errors[:down_payment_rate]).to include("must be greater than or equal to 10 and less than or equal to 100")

      loan.down_payment_rate = 150
      expect(loan).not_to be_valid

      loan.down_payment_rate = 20
      expect(loan).to be_valid
    end
  end

  describe "enums" do
    it "defines valid values for action_type" do
      expect(loan).to define_enum_for(:action_type).with_values(
        buy_a_new_home: 0,
        refinance_my_home_loan: 1
      )
    end

    it "defines valid values for property_type" do
      expect(loan).to define_enum_for(:property_type).with_values(
        single_family_home: 0,
        town_home: 1,
        condominium: 2,
        apartment: 3,
        other: 4
      )
    end

    it "defines valid values for user_situation" do
      expect(loan).to define_enum_for(:user_situation).with_values(
        practicing_hospitalitist: 0,
        exciting_fellowship: 1,
        exciting: 2,
        self_employed_clinician: 3
      )
    end
  end

  describe "callbacks" do
    context "before_save" do
      it "formats date before save" do
        loan.date = Date.new(2024, 12, 25)
        loan.save
        expect(loan.date.strftime("%B %d, %Y")).to eq("December 25, 2024")
      end

      it "calculates monthly payment before save" do
        loan.save
        expect(loan.monthly_payment).to eq(2_684.11)
      end

      it "calculates reverse amount before save" do
        loan.save
        expect(loan.reverse_amount).not_to be_nil
      end
    end
  end
end
