# This migration comes from spree (originally 20130207155350)
class AddOrderIdIndexToPayments < ActiveRecord::Migration[4.2]
  def self.up
    add_index :spree_payments, :order_id
  end

  def self.down
    remove_index :spree_payments, :order_id
  end
end
