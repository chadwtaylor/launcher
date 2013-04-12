class TaylorTools::TTPhoneNumber < TaylorTools

	# attr_accessor :phone_number
	# attr_accessor :extension
	# attr_accessor :garbage
	
	FORMAT_DEFAULT = 0
	FORMAT_INTL = 9

	def self.decorate(number)

		number = number.to_s
		n = strip_special_characters(number)

		format = FORMAT_DEFAULT
		decor = ""

		if (n[0,3].to_s.eql?"011")
			n = n[3,n.length]
			format = FORMAT_INTL
		end

		if is_alpha_numeric?(n)
		
			n_start = n[0,1].to_i
			n_start = n_start == 1 ? 1 : 0
			n_end = 3 + n_start
			len = n.length

			if (len == 10 || len == 11)
				return "(#{get_NPA(n)}) #{get_NXX(n,false)}-#{get_XXXX(n,false)}"
			end

			n_part_one = ""

			begin
				n_part_one = n[n_start,n_end]
			rescue
				return number
			end

			if is_alpha_numeric?(n_part_one)
				return number
			end

			n_part_two = n[n_end,n.length]

			return "(#{n_part_one.to_s}) #{n_part_two.to_s}"

		end
		
		if n.length == 7 || n.length == 10 || n.length == 11

			is7 = n.length == 7

			case format
				when FORMAT_DEFAULT
					decor = is7 ? "" : "(#{get_NPA(n)}) "
					decor += "#{get_NXX(n)}-#{get_XXXX(n)}"
				when FORMAT_INTL
					decor = "011 #{n}"
				else
					return number
			end

		elsif format == FORMAT_INTL
			number = "011 #{n}"
		end

		return decor.to_s.eql?("") ? number : decor
	end

	def self.get_NPA(number)
		return TaylorTools::TTNANPA.get_NPA(number)
	end

	def self.get_NXX(number, is_numerize=true)
		return TaylorTools::TTNANPA.get_NXX(number, is_numerize)
	end

	def self.get_XXXX(number, is_numerize=true)
		return TaylorTools::TTNANPA.get_XXXX(number, is_numerize)
	end

	def self.is_alpha_numeric?(number)
		number = strip_special_characters(number)
		number.each do |n|
			x = n.to_i
			return true unless x.to_s.eql?n.to_s
		end
		return false
	end

	def self.is_emergency?(number)
		return number.to_s.eql?"911"
	end

	def self.is_international?(number)
		return number[0,3].to_s.eql?"011"# || number[0,4].to_s.eql?"1011"
	end

	def self.is_valid?(number)
		return TaylorTools::TTNANPA.is_valid?(number)
	end

	def self.numerize(text)
		number = ""
		text = strip_special_characters(text).upcase

		text.each_char do |char|
			number += numerize_letter(char)
		end

		return number
	end

	def self.numerize_letter(char)
		return char if TaylorTools::Validation.is_numeric?(char)
		case char
			when ('A'..'C')
				return "2"
			when ('D'..'F')
				return "3"
			when ('G'..'I')
				return "4"
			when ('J'..'L')
				return "5"
			when ('M'..'O')
				return "6"
			when ('P'..'S')
				return "7"
			when ('T'..'V')
				return "8"
			when ('W'..'Z')
				return "9"
			else 
				return "0"
		end
	end

	def self.strip_special_characters(text)
		begin
			text = text.to_s
			return text.gsub(/[^a-zA-Z0-9]/,"")
		rescue
			return text
		end
	end

	def self.strip_leading_one_digit(pn)
		return (pn[0,1].to_s == "1" && pn.length == 11) ? pn[1,pn.length] : pn
	end

end
