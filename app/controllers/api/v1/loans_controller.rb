class Api::V1::LoansController < ApplicationController
  before_action :set_loan, only: %i[update show]
  rescue_from ActionController::ParameterMissing, with: :handle_missing_params

  def index
    @loans = Loan.joins(:form_progress).where(form_progresses: { form_completed: true })
    incompleted_loan_candidate = Loan.joins(:form_progress).where(form_progresses: { form_completed: [nil, false] }).first

    response_data = {
      loans: ActiveModelSerializers::SerializableResource.new(@loans, each_serializer: LoanShowSerializer)
    }

    if incompleted_loan_candidate
      response_data[:incompleted_loan_form] = LoanCreateUpdateSerializer.new(incompleted_loan_candidate)
    end

    render json: response_data, status: :ok
  end

  def create
    incompleted_loan_candidate = Loan.joins(:form_progress).where(form_progresses: { form_completed: [nil, false] }).first

    if incompleted_loan_candidate
      render json: { error: 'Loan already exists' }, status: :conflict
      return
    end

    loan_form = LoanForm.new(Loan.new(loan_params), FormProgress.new(form_progress_params), loan_params, form_progress_params)
    if loan_form.save
      render json: loan_form.loan, serializer: LoanCreateUpdateSerializer, status: :created
    else
      render json: loan_form.loan.errors, status: :unprocessable_entity
    end
  end

  def update
    loan_form = LoanForm.new(@loan, @form_progress, loan_params, form_progress_params)

    if loan_form.update
      render json: loan_form.loan, serializer: LoanCreateUpdateSerializer, status: :ok
    else
      render json: loan_form.loan.errors, status: :unprocessable_entity
    end
  end

  def show  
    render json: @loan, serializer: LoanShowSerializer, status: :ok
  end

  private

  def loan_params
    params.require(:loan).permit(:action_type, :down_payment, :country, :address,
                                 :latitude, :longitude, :zip_code, :property_type, :price,
                                 :down_payment_rate, :user_situation, :date, :duration, :rate, :gift_funds)
  end

  def form_progress_params
    params.require(:form_progress).permit(:active_step)
  end

  def set_loan
    @loan = Loan.find_by(id: params[:id])
    
    if @loan.nil?
      render json: { error: 'Loan not found' }, status: :not_found
    else
      @form_progress = @loan.form_progress
    end
  end

  def handle_missing_params(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
