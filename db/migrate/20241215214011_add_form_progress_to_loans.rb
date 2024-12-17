class AddFormProgressToLoans < ActiveRecord::Migration[8.0]
  def change
    add_reference :loans, :form_progress, null: false, foreign_key: true
  end
end
