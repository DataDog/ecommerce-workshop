# This migration comes from spree (originally 20140307235515)
class AddUserIdToSpreeCreditCards < ActiveRecord::Migration[4.2]
  def change
    unless Spree::CreditCard.column_names.include? "user_id"
      add_column :spree_credit_cards, :user_id, :integer
      add_index :spree_credit_cards, :user_id
    end

    unless Spree::CreditCard.column_names.include? "payment_method_id"
      add_column :spree_credit_cards, :payment_method_id, :integer
      add_index :spree_credit_cards, :payment_method_id
    end
  end
end
