# This migration comes from spree (originally 20170330132215)
class AddIndexOnPromotionIdToOrderPromotions < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_order_promotions, :promotion_id
  end
end
