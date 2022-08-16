# This migration comes from spree (originally 20140808184039)
class CreateSpreeReimbursementCredits < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_reimbursement_credits do |t|
      t.decimal :amount, precision: 10, scale: 2, default: 0.0, null: false
      t.integer :reimbursement_id
      t.integer :creditable_id
      t.string  :creditable_type
    end
  end
end
