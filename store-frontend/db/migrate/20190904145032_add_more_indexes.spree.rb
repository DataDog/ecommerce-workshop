# This migration comes from spree (originally 20140213184916)
class AddMoreIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :spree_payment_methods, [:id, :type]
    add_index :spree_calculators, [:id, :type]
    add_index :spree_calculators, [:calculable_id, :calculable_type]
    add_index :spree_payments, :payment_method_id
    add_index :spree_promotion_actions, [:id, :type]
    add_index :spree_promotion_actions, :promotion_id
    add_index :spree_promotions, [:id, :type]
    add_index :spree_option_values, :option_type_id
    add_index :spree_shipments, :stock_location_id
  end
end
