# This migration comes from spree (originally 20130301205200)
class AddTrackingUrlToSpreeShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_shipping_methods, :tracking_url, :string
  end
end
