# This migration comes from spree (originally 20170722102643)
class AddAnalyticsKindToSpreeTrackers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_trackers, :kind, :integer, default: 0, null: false, index: true
  end
end
