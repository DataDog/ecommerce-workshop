# This migration comes from spree (originally 20140207085910)
class AddTaxCategoryIdToShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_shipping_methods, :tax_category_id, :integer
  end
end
