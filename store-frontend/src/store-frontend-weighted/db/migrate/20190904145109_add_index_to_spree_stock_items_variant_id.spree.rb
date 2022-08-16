# This migration comes from spree (originally 20150216173445)
class AddIndexToSpreeStockItemsVariantId < ActiveRecord::Migration[4.2]
  def up
    unless index_exists? :spree_stock_items, :variant_id
      add_index :spree_stock_items, :variant_id
    end
  end

  def down
    if index_exists? :spree_stock_items, :variant_id
      remove_index :spree_stock_items, :variant_id
    end
  end
end
