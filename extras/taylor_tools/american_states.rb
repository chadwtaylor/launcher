class TaylorTools::AmericanStates < TaylorTools

	def self.is_state_valid?(state)

		state = state.upcase

		for s in get_state_list
			if s.name.upcase.eql?(state) || s.abbv.upcase.eql?(state)
				return true
			end
		end

		return false

	end

	def self.get_state_list
		list = Array.new

		state = Hashie::Mash.new
		state.name = "Alabama"
		state.abbv = "AL"
		list << state

		state = Hashie::Mash.new
		state.name = "Alaska"
		state.abbv = "AK"
		list << state

		state = Hashie::Mash.new
		state.name = "American Samoa"
		state.abbv = "AS"
		list << state

		state = Hashie::Mash.new
		state.name = "Arizona"
		state.abbv = "AZ"
		list << state

		state = Hashie::Mash.new
		state.name = "Arkansas"
		state.abbv = "AR"
		list << state

		state = Hashie::Mash.new
		state.name = "California"
		state.abbv = "CA"
		list << state

		state = Hashie::Mash.new
		state.name = "Colorado"
		state.abbv = "CO"
		list << state

		state = Hashie::Mash.new
		state.name = "Connecticut"
		state.abbv = "CT"
		list << state

		state = Hashie::Mash.new
		state.name = "Delaware"
		state.abbv = "DE"
		list << state

		state = Hashie::Mash.new
		state.name = "District of Columbia"
		state.abbv = "DC"
		list << state

		state = Hashie::Mash.new
		state.name = "Federated States of Micronesia"
		state.abbv = "FM"
		list << state

		state = Hashie::Mash.new
		state.name = "Florida"
		state.abbv = "FL"
		list << state

		state = Hashie::Mash.new
		state.name = "Georgia"
		state.abbv = "GA"
		list << state

		state = Hashie::Mash.new
		state.name = "Guam"
		state.abbv = "GU"
		list << state

		state = Hashie::Mash.new
		state.name = "Hawaii"
		state.abbv = "HI"
		list << state

		state = Hashie::Mash.new
		state.name = "Idaho"
		state.abbv = "ID"
		list << state

		state = Hashie::Mash.new
		state.name = "Illinois"
		state.abbv = "IL"
		list << state

		state = Hashie::Mash.new
		state.name = "Indiana"
		state.abbv = "IN"
		list << state

		state = Hashie::Mash.new
		state.name = "Iowa"
		state.abbv = "IA"
		list << state

		state = Hashie::Mash.new
		state.name = "Kansas"
		state.abbv = "KS"
		list << state

		state = Hashie::Mash.new
		state.name = "Kentucky"
		state.abbv = "KY"
		list << state

		state = Hashie::Mash.new
		state.name = "Louisiana"
		state.abbv = "LA"
		list << state

		state = Hashie::Mash.new
		state.name = "Maine"
		state.abbv = "ME"
		list << state

		state = Hashie::Mash.new
		state.name = "Marshall Islands"
		state.abbv = "MH"
		list << state

		state = Hashie::Mash.new
		state.name = "Maryland"
		state.abbv = "MD"
		list << state

		state = Hashie::Mash.new
		state.name = "Massachusetts"
		state.abbv = "MA"
		list << state

		state = Hashie::Mash.new
		state.name = "Michigan"
		state.abbv = "MI"
		list << state

		state = Hashie::Mash.new
		state.name = "Minnesota"
		state.abbv = "MN"
		list << state

		state = Hashie::Mash.new
		state.name = "Mississippi"
		state.abbv = "MS"
		list << state

		state = Hashie::Mash.new
		state.name = "Missouri"
		state.abbv = "MO"
		list << state

		state = Hashie::Mash.new
		state.name = "Montana"
		state.abbv = "MT"
		list << state

		state = Hashie::Mash.new
		state.name = "Nebraska"
		state.abbv = "NE"
		list << state

		state = Hashie::Mash.new
		state.name = "Nevada"
		state.abbv = "NV"
		list << state

		state = Hashie::Mash.new
		state.name = "New Hampshire"
		state.abbv = "NH"
		list << state

		state = Hashie::Mash.new
		state.name = "New Jersey"
		state.abbv = "NJ"
		list << state

		state = Hashie::Mash.new
		state.name = "New Mexico"
		state.abbv = "NM"
		list << state

		state = Hashie::Mash.new
		state.name = "New York"
		state.abbv = "NY"
		list << state

		state = Hashie::Mash.new
		state.name = "North Carolina"
		state.abbv = "NC"
		list << state

		state = Hashie::Mash.new
		state.name = "North Dakota"
		state.abbv = "ND"
		list << state

		state = Hashie::Mash.new
		state.name = "Northern Mariana Islands"
		state.abbv = "MP"
		list << state

		state = Hashie::Mash.new
		state.name = "Ohio"
		state.abbv = "OH"
		list << state

		state = Hashie::Mash.new
		state.name = "Oklahoma"
		state.abbv = "OK"
		list << state

		state = Hashie::Mash.new
		state.name = "Oregon"
		state.abbv = "OR"
		list << state

		state = Hashie::Mash.new
		state.name = "Palau"
		state.abbv = "PW"
		list << state

		state = Hashie::Mash.new
		state.name = "Pennsylvania"
		state.abbv = "PA"
		list << state

		state = Hashie::Mash.new
		state.name = "Puerto Rico"
		state.abbv = "PR"
		list << state

		state = Hashie::Mash.new
		state.name = "Rhode Island"
		state.abbv = "RI"
		list << state

		state = Hashie::Mash.new
		state.name = "South Carolina"
		state.abbv = "SC"
		list << state

		state = Hashie::Mash.new
		state.name = "South Dakota"
		state.abbv = "SD"
		list << state

		state = Hashie::Mash.new
		state.name = "Tennessee"
		state.abbv = "TN"
		list << state

		state = Hashie::Mash.new
		state.name = "Texas"
		state.abbv = "TX"
		list << state

		state = Hashie::Mash.new
		state.name = "Utah"
		state.abbv = "UT"
		list << state

		state = Hashie::Mash.new
		state.name = "Vermont"
		state.abbv = "VT"
		list << state

		state = Hashie::Mash.new
		state.name = "Virgin Islands"
		state.abbv = "VI"
		list << state

		state = Hashie::Mash.new
		state.name = "Virginia"
		state.abbv = "VA"
		list << state

		state = Hashie::Mash.new
		state.name = "Washington"
		state.abbv = "WA"
		list << state

		state = Hashie::Mash.new
		state.name = "West Virginia"
		state.abbv = "WV"
		list << state

		state = Hashie::Mash.new
		state.name = "Wisconsin"
		state.abbv = "WI"
		list << state

		state = Hashie::Mash.new
		state.name = "Wyoming"
		state.abbv = "WY"
		list << state

		return list
	end

end  
