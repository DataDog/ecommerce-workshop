# This migration comes from spree (originally 20130226032817)
class ChangeMetaDescriptionOnSpreeProductsToText < ActiveRecord::Migration[4.2]
  def change
    change_column :spree_products, :meta_description, :text, limit: nil
  end
end
