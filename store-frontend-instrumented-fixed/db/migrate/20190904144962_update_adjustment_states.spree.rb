# This migration comes from spree (originally 20130417120035)
class UpdateAdjustmentStates < ActiveRecord::Migration[4.2]
  def up
    Spree::Order.complete.find_each do |order|
      order.adjustments.update_all(state: 'closed')
    end

    Spree::Shipment.shipped.includes(:adjustment).find_each do |shipment|
      shipment.adjustment.update_column(:state, 'finalized') if shipment.adjustment
    end

    Spree::Adjustment.where(state: nil).update_all(state: 'open')
  end

  def down
  end
end
