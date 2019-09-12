# This migration comes from spree (originally 20170331110454)
class AddIndexesToRefunds < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_refunds, :payment_id
    add_index :spree_refunds, :reimbursement_id
  end
end
