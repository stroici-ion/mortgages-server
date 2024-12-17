class AddFormCompletedToFormProgresses < ActiveRecord::Migration[8.0]
  def change
    add_column :form_progresses, :form_completed, :boolean, default: false, null: false
  end
end
