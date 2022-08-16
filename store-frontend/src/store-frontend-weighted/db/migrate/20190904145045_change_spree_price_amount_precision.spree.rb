# This migration comes from spree (originally 20140508151342)
class ChangeSpreePriceAmountPrecision < ActiveRecord::Migration[4.2]
  def change
    change_column :spree_prices, :amount,  :decimal, precision: 10, scale: 2
    change_column :spree_line_items, :price,  :decimal, precision: 10, scale: 2
    change_column :spree_line_items, :cost_price,  :decimal, precision: 10, scale: 2
    change_column :spree_variants, :cost_price, :decimal, precision: 10, scale: 2
  end
end
