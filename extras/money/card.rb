class Money::Card < Money

	# delinquent (boloean)

	class << self

		def create(card)
			puts "********************************************************************************"
			puts "card: #{card.inspect}"
			token_id = Money::Token.create(card)
			puts "token_id: #{token_id}"
			c = Stripe::Customer.create(description: card.full_name, card: token_id)
			return c.id
		end

		def retrieve(customer_id)
			c = Stripe::Customer.retrieve(customer_id)
			customer = Hashie::Mash.new
			customer.delinquent = c.delinquent
			customer.account_balance = c.account_balance
			return customer
		end
		
	end

end  

=begin

card = Hashie::Mash.new
card.number = "4242424242424242"
card.cvc = "611"
card.full_name = "Chad Taylor"
card.expire_month = "02"
card.expire_year = "2015"
card.street1 = "37200 Paseo Padre Pkwy"
card.street2 = "APT 130"
card.city = "Fremont"
card.state = "CA"
card.zip_code = "94536"
card.country = "USA"
p = Person.find(1)
c = Money::Card.create(p, card)

=end