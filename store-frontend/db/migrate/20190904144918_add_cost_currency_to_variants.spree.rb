# This migration comes from spree (originally 20121109173623)
class AddCostCurrencyToVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_variants, :cost_currency, :string, after: :cost_price
  end
end
