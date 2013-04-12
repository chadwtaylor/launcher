class TaylorTools::TTNANPA < TaylorTools

	# NANPA = North America Number Plan Association
	
	def self.is_phone_number?(number)
		return TaylorTools::Validation.is_possible_phone_number?(number)
	end
	
	def self.get_NPA(number)
		return "invalid number" unless is_phone_number?(number)
		#number = numerize(number) 
		case number.length
			when 11 
				# puts "**********************************************************************"
				# puts "get_NPA"
				# puts "number[0,1] = #{number[0,1]}"
				# puts "number[1,3] = #{number[1,3]}"
				
				if number[0,1].to_i == 1
					# puts "return 1,3"
					return number[1,3]
				end
				# puts "return 0,3"
				return number[0,3]
			when 10 
				# puts "10: return 0,3"
				return number[0,3]
		end
		return ""
	end

	def self.get_NXX(number, is_numerize=true)
		return "invalid number" unless is_phone_number?(number)
		number = numerize(number) if is_numerize
		case number.length
			when 11 
				if number[0,1].to_i == 1
					return number[4,3]
				end
				return number[3,3]
			when 10 
				return number[3,3]
			when 7 
				return number[0,3]
		end
		return ""
	end

	def self.get_XXXX(number, is_numerize=true)
		return "invalid number" unless is_phone_number?(number)
		number = numerize(number) if is_numerize
		length = number.length
		case length
			when 11
				if number[0,1].to_i == 1
					return number[7,length]
				end
				return number[6,length]
			when 10
				return number[6,length]
			when 7 
				return number[3,length]
		end
		return ""
	end

	def self.is_valid?(number)

		if TaylorTools::Validation.is_email_valid?(number) ||
		   TaylorTools::Validation.is_ip_or_dns_valid?(number)
		   return false
		end

		number = numerize(number)

		return true if number.to_s[0,3].eql?"011"

		case number.length
			when 3
				n = number.to_i
				return true if (n==911 || n==411 || n==211 || n==311)
			when 7
				return false
			when 10..11
				return is_valid_NPA?(number) && is_valid_NXX?(number)
			when 12..18
				return true # 1-800-DISCOVER is a valid number (length: 12)
		end
		return false
	end

	def self.is_valid_NPA?(number)
		invalid_list = "000 111 100 111 411 511 555 611 711 811 911 976".split(" ")
		npa = get_NPA(number)
		invalid_list.each do |x|
			return false if x.eql?(npa)
		end
		return true
	end

	def self.is_valid_NXX?(number)
		invalid_list = "000 011 100 111 511 611".split(" ")
		nxx = get_NXX(number)
		invalid_list.each do |x|
			return false if x.eql?(nxx)
		end
		return true
	end

	def self.numerize(number)
		return TaylorTools::TTPhoneNumber.numerize(number)
	end

end
