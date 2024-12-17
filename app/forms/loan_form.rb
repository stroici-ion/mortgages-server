class LoanForm
  include ActiveModel::Model

  attr_accessor :loan, :form_progress, :loan_params, :form_progress_params

  def initialize(loan, form_progress, loan_params, form_progress_params)
    @loan_params = loan_params
    @form_progress_params = form_progress_params
    @loan = loan
    @form_progress = form_progress
  end

  def save
    return false if form_progress.invalid?

    loan.form_progress = form_progress

    if loan.save
      update_form_progress
      form_progress.save
      true
    else
      false
    end
  end

  def update
    if loan.update(loan_params)
      @form_progress.active_step = form_progress_params[:active_step]
      update_form_progress
      form_progress.save
      true
    else
      false
    end
  end

  private


  def update_form_progress
    case form_progress.active_step.to_sym
    when :action_type_step
      form_progress.action_type_completed = true
    when :location_step
      form_progress.location_completed = true
    when :property_type_step
      form_progress.property_type_completed = true
    when :price_step
      form_progress.price_completed = true
    when :user_situation_step
      form_progress.about_user_completed = true
    when :targets_step
      form_progress.targets_completed = true
    when :date_step
      form_progress.date_completed = true
    when :gift_funds_step
      form_progress.gift_funds_completed = true
    end
  end
end
