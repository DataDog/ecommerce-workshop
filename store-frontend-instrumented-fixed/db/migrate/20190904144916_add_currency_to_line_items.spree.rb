# This migration comes from spree (originally 20121107184631)
class AddCurrencyToLineItems < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_line_items, :currency, :string
  end
end
