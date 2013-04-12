class Money::Token < Money

	# name
	# card_type
	# last4
	# expire_month
	# expire_year
	# street1
	# street2
	# city
	# state
	# zip_code

	class << self

		def create(card)

			c = Hashie::Mash.new
			c.name = card.full_name if card.full_name rescue nil
			c.number = card.number
			c.exp_month = card.expire_month
			c.exp_year = card.expire_year
			c.cvc = card.cvc
			c.address_line1 = card.street1 if card.street1
			c.address_line2 = card.street2 if card.street2
			c.address_zip = card.zip_code 
			c.address_state = card.state if card.state
			c.address_country = card.country if card.country

			t = Stripe::Token.create(card:c)
			return t.id

		end

		# def retrieve(token_id)
		# 	t = Stripe::Token.retrieve(token_id)
		# 	token = Hashie::Mash.new
		# 	token.full_name = t.name
		# 	token.card_type = t.card.type
		# 	token.last4 = t.card.last4
		# 	token.expire_month = t.card.exp_month
		# 	token.expire_year = t.card.exp_year
		# 	token.street1 = t.card.address_line1
		# 	token.street2 = t.card.address_line2
		# 	token.city = t.card.address_city
		# 	token.state = t.card.address_state
		# 	token.zip_code = t.card.address_zip
		# 	return token 
		# end

	end

end  
