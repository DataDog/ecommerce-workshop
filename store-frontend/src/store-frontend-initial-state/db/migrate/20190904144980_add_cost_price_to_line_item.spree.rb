# This migration comes from spree (originally 20130718042445)
class AddCostPriceToLineItem < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_line_items, :cost_price, :decimal, precision: 8, scale: 2
  end
end
