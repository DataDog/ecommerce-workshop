# This migration comes from spree (originally 20130228164411)
class RemoveOnDemandFromProductAndVariant < ActiveRecord::Migration[4.2]
  def change
    remove_column :spree_products, :on_demand
    remove_column :spree_variants, :on_demand
  end
end
