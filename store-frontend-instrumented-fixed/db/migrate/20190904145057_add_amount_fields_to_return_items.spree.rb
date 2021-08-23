# This migration comes from spree (originally 20140710181204)
class AddAmountFieldsToReturnItems < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_return_items, :pre_tax_amount, :decimal, precision: 10, scale: 2, default: 0.0, null: false
    add_column :spree_return_items, :included_tax_total, :decimal, precision: 10, scale: 2, default: 0.0, null: false
    add_column :spree_return_items, :additional_tax_total, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
