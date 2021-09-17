# This migration comes from spree (originally 20140120160805)
class AddIndexToVariantIdAndCurrencyOnPrices < ActiveRecord::Migration[4.2]
  def change
    add_index :spree_prices, [:variant_id, :currency]
  end
end
