class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.integer :action_type
      t.string :country
      t.string :address
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.integer :property_type
      t.decimal :price
      t.decimal :down_payment_rate
      t.decimal :down_payment
      t.integer :user_situation
      t.date :date
      t.integer :duration
      t.decimal :monthly_payment
      t.decimal :rate
      t.decimal :reverse_amount
      t.decimal :gift_funds
      t.string :is_document_reviewed
      t.string :is_pending_final_approval
      t.string :is_approved

      t.timestamps
    end
  end
end
