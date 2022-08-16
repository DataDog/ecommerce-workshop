# This migration comes from spree (originally 20140716204111)
class DropReceivedAtOnReturnItems < ActiveRecord::Migration[4.2]
  def up
    remove_column :spree_return_items, :received_at
  end

  def down
    add_column :spree_return_items, :received_at, :datetime
  end
end
