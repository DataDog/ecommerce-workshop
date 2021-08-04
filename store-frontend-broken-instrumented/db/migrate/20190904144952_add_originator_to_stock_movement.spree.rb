# This migration comes from spree (originally 20130319183250)
class AddOriginatorToStockMovement < ActiveRecord::Migration[4.2]
  def change
    change_table :spree_stock_movements do |t|
      t.references :originator, polymorphic: true
    end
  end
end
