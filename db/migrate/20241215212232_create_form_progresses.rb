class CreateFormProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :form_progresses do |t|      
      t.boolean :action_type_completed
      t.boolean :location_completed
      t.boolean :property_type_completed
      t.boolean :price_completed
      t.boolean :about_user_completed
      t.boolean :date_completed
      t.boolean :targets_completed
      t.boolean :gift_funds_completed

      t.timestamps
    end
  end
end
