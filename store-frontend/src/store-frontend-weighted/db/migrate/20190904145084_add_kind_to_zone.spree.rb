# This migration comes from spree (originally 20140911173301)
class AddKindToZone < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_zones, :kind, :string
    add_index :spree_zones, :kind

    Spree::Zone.find_each do |zone|
      last_type = zone.members.where.not(zoneable_type: nil).pluck(:zoneable_type).last
      zone.update_column :kind, last_type.demodulize.underscore if last_type
    end
  end
end
