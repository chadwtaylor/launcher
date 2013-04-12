class TaylorTools::Validation < TaylorTools

	def self.is_email_valid?(email)
		return email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/ ? true : false
	end

	def self.is_ip_valid?(ip)
		return ip =~ /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/ ? true : false
	end

	def self.is_dns_valid?(dns)
		return dns =~ /^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$/ ? true : false
	end

	def self.is_ip_or_dns_valid?(value)
		return is_ip_valid?(value) || is_dns_valid?(value) ? true : false
	end

	def self.is_possible_phone_number?(value)
		return false if is_ip_valid?(value) || is_dns_valid?(value)

		s = TaylorTools::TTPhoneNumber.strip_special_characters(value)

		s3 = s.to_s[0,3]

		if s3.eql?("011") || s3.eql?("911") || s3.eql?("411") || s3.eql?("311") || s3.eql?("211")
			return true
		end

		if s.length > 2
			s = s[0,3]
			i = s.to_i
			return s.eql?i.to_s
		end
		
		return false
	end

	def self.is_numeric?(value)

		# TODO improve regex logic to accept all kinds of numeric: whole, digital, float, integer
		# http://regexlib.com/DisplayPatterns.aspx?cattabindex=2&categoryId=3
		
		# bool = (value =~ /^[-+]?[0-9]*\.?[0-9]+$/ ? true : false)
		# return value =~ /^[0-9]*$/ ? true : false
		
		# b = (value =~ /^\d+$/ ? true : false)
		# b = (value =~ /^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$/ ? true : false)

		s = value
		i = value.to_i
		b = s.to_s.eql?(i.to_s)
		return b
	end

end  
