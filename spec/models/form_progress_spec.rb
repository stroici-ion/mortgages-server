require 'rails_helper'

RSpec.describe FormProgress, type: :model do
  it { should validate_presence_of(:active_step) }

  it { should define_enum_for(:active_step).with_values(
    action_type_step: 0,
    location_step: 1,
    property_type_step: 2,
    price_step: 3,
    user_situation_step: 4,
    targets_step: 5,
    date_step: 6,
    gift_funds_step: 7
  ) }

  describe '#check_form_completed' do
    context 'when all steps are completed' do
      it 'sets form_completed to true' do
        form_progress = FormProgress.new(
          action_type_completed: true,
          location_completed: true,
          property_type_completed: true,
          price_completed: true,
          about_user_completed: true,
          date_completed: true,
          targets_completed: true,
          gift_funds_completed: true,
          active_step: :action_type_step
        )
        form_progress.save
        expect(form_progress.form_completed).to be true
      end
    end

    context 'when one or more steps are incomplete' do
      it 'sets form_completed to false' do
        form_progress = FormProgress.new(
          action_type_completed: true,
          location_completed: false,
          property_type_completed: true,
          price_completed: true,
          about_user_completed: true,
          date_completed: true,
          targets_completed: true,
          gift_funds_completed: true,
          active_step: :action_type_step
        )
        form_progress.save
        expect(form_progress.form_completed).to be false
      end
    end
  end

  it 'should not be valid without an active_step' do
    form_progress = FormProgress.new
    expect(form_progress.valid?).to be false
  end

  it 'should save with a valid active_step enum' do
    form_progress = FormProgress.create(
      action_type_completed: true,
      location_completed: true,
      property_type_completed: true,
      price_completed: true,
      about_user_completed: true,
      date_completed: true,
      targets_completed: true,
      gift_funds_completed: true,
      active_step: :action_type_step
    )
    expect(form_progress.active_step).to eq('action_type_step')
  end
end
