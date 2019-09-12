# This migration comes from spree (originally 20140717155155)
class CreateDefaultRefundReason < ActiveRecord::Migration[4.2]
  def up
    Spree::RefundReason.create!(name: Spree::RefundReason::RETURN_PROCESSING_REASON, mutable: false)
  end

  def down
    Spree::RefundReason.find_by(name: Spree::RefundReason::RETURN_PROCESSING_REASON, mutable: false).destroy
  end
end
