class Order < ActiveRecord::Base

  # ---------------------------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------------------------
  belongs_to :person
  belongs_to :reward
  belongs_to :shipping_address, class_name: Address
  belongs_to :billing_address, class_name: Address

  # ---------------------------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------------------------

  # ---------------------------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------------------------

  # ---------------------------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------------------------

  # ------------------------------------------------------------------------------------------------------
  # Class Methods
  # ------------------------------------------------------------------------------------------------------
  def self.grand_total
    return (Order.total_amount + Order.total_contributions) / 100
  end

  def self.limited_backers
    return Order.joins(:reward).where("rewards.backers_limit > 0").group("rewards.id")
  end

  def self.total_amount
    return Order.campaign_summary.total_amount.to_i
  end

  def self.total_contributions
    return Order.campaign_summary.total_contributions.to_i
  end

  def self.total_orders
    return Order.campaign_summary.total_orders.to_i
  end

  def self.campaign_summary
    return Order.joins(:reward)
                .select('sum(rewards.amount) as total_amount, count(*) as total_orders, sum(contribution_amount) as total_contributions')
                .first# .contribution_amount
  end

  def self.backers_summary
    orders = Order.joins(:reward).select('rewards.id as reward_id, count(*) as total_backers').group('rewards.id') 
    temp = Hashie::Mash.new
    orders.each do |order|
      temp[order.reward_id] = order.total_backers
    end
    return temp
  end

  # ------------------------------------------------------------------------------------------------------
  # Private
  # ------------------------------------------------------------------------------------------------------
  private

end
