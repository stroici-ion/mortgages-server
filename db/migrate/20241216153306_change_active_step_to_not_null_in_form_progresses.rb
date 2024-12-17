class ChangeActiveStepToNotNullInFormProgresses < ActiveRecord::Migration[8.0]
  def change
    change_column_null :form_progresses, :active_step, false
  end
end
