class Money::Charge < Money

	class << self

		# amount*							: in cents
		# currency*						: "usd"
		# customer						: customer ID 
		# - card  						: this is not used if Customer ID is supplied above
		# 	  number*					: cc number
		# 		exp_month*	
		# 		exp_year*
		# 		cvc							: security code on back of card
		# 		name						: full name as shown on card
		# 		address_line1		
		# 		address_line2
	  #   	address_zip
	  # 		address_state
	  # 		address_country
	  
		def process(amount, currency, customer_id, card={})
			o = Hashie::Mash.new
			o.amount = amount
			o.currency = currency
			o.customer = customer_id unless customer_id.blank?
			o.card = card unless card.blank?
			c = Stripe::Charge.create(o)
			return c
		end

		def retrieve(charge_id)
			c = Stripe::Charge.retrieve(charge_id)
			return c 
		end

		def refund(charge_id)
			c = Stripe::Charge.retrieve(charge_id)
			c.refund
			return c
		end

		def list(count=10, offset=0)
			c = Stripe::Charge.all(count:count, offest:offset)
			return c
		end

		def list_by_customer(customer)
			c = Stripe::Charge.all(customer:customer.id)
			return c
		end

	end

end  
