# This migration comes from spree (originally 20131127001002)
class AddPositionToClassifications < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_products_taxons, :position, :integer
  end
end
