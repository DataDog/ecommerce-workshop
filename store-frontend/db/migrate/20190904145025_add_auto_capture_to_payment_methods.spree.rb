# This migration comes from spree (originally 20140204192230)
class AddAutoCaptureToPaymentMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_payment_methods, :auto_capture, :boolean
  end
end
