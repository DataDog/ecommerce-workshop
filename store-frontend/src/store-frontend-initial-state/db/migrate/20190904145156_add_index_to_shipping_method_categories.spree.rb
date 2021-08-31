# This migration comes from spree (originally 20170331123625)
class AddIndexToShippingMethodCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_shipping_method_categories, :shipping_category_id
  end
end
