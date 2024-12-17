class AddActiveStepToFormProgresses < ActiveRecord::Migration[8.0]
  def change
    add_column :form_progresses, :active_step, :integer
  end
end
