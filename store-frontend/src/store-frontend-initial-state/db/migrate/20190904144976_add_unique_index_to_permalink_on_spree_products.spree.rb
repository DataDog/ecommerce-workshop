# This migration comes from spree (originally 20130628021056)
class AddUniqueIndexToPermalinkOnSpreeProducts < ActiveRecord::Migration[4.2]
  def change
    add_index "spree_products", ["permalink"], name: "permalink_idx_unique", unique: true
  end
end
