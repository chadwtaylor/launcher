class Reward < ActiveRecord::Base

  # ---------------------------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------------------------
  has_many :orders

  # ---------------------------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------------------------

  # ---------------------------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------------------------

  # ---------------------------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------------------------
  def supporter?
    return self.subject.upcase == "SUPPORTER"
  end

  def tshirt_only?
    return self.subject.upcase == "T-SHIRT BACKER"
  end

  # ------------------------------------------------------------------------------------------------------
  # Class Methods
  # ------------------------------------------------------------------------------------------------------

  # ------------------------------------------------------------------------------------------------------
  # Private
  # ------------------------------------------------------------------------------------------------------
  private

    def self.write(index, amount, subject, summary, limit=nil, tshirt=false, shipable=true)
      r = Reward.new
      r.index = index
      r.amount = amount
      r.subject = subject
      r.summary = summary
      r.backers_limit = limit
      r.tshirt_included = tshirt
      r.is_shipable = shipable
      r.save
    end

end
