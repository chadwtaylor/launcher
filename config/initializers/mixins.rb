class ActiveRecord::Base

	def self.find(*ids)

		ids = ids.flatten
		class_name = self.name

		if ids.first.to_s.is_numeric?
			ids = ids.map{|s|s.to_i}
			results = super(ids)
			return results.length <= 1 ? results.first : results
		elsif ids.first.to_s.is_uuid?
			results = self.where(uuid:ids)
			if results.blank?
				raise ActiveRecord::RecordNotFound.new("Couldn't find #{class_name} with uuid=#{ids.first}") if ids.length <= 1
				raise ActiveRecord::RecordNotFound.new("Couldn't find all #{class_name.pluralize} with UUIDs (#{ids.join(', ')})")
			end
			return results.length <= 1 ? results.first : results
		end

		raise ActiveRecord::RecordNotFound.new("Couldn't find #{class_name} with #{ids.first}") if ids.length <= 1
		raise ActiveRecord::RecordNotFound.new("Couldn't find all #{class_name.pluralize} with (#{ids.join(', ')})")

	end

end

class Hashie::Mash
	def self.ize(json)
		return Hashie::Mash.new(json) if json.is_a?(Hash)
		json = ActiveSupport::JSON.decode(json) rescue ActiveSupport::JSON.decode(json.to_json)
		mash = json.map { |j| Hashie::Mash.new(j) }
		return mash
	end
end

class Array
	def to_mash; return Hashie::Mash.ize(self); end
end

class Hash
	def to_mash; return Hashie::Mash.ize(self); end
end

class String

	def to_boolean
		case self
			when "1", "true", "t"; return true
			else return false
		end
	end

	def to_human_date
		return DateTime.parse(self).to_human_date
	end

	def to_human_time
		return DateTime.parse(self).to_human_time
	end

	def to_human_datetime
		return DateTime.parse(self).to_human_datetime
	end

	def to_money
		return "%.2f" % self.to_f
	end

	def is_numeric?
		return true if Float(self) rescue false
	end

	def is_uuid?
		return (self.length == 36 && self.split("-").length == 5) rescue false
	end

	def last(n)
		return self[-n,n]
	end

end

class DateTime

	def to_human_date
		return self.strftime("%m/%d/%Y")
	end

	def to_human_time
		return self.strftime("%I:%M %p")
	end

	def to_human_datetime
		return "#{self.to_human_date} #{self.to_human_time}"
	end

end

class Time

	def to_human_date
		return self.strftime("%m/%d/%Y")
	end

	def to_human_time
		return self.strftime("%I:%M %p")
	end

	def to_human_datetime
		return "#{self.to_human_date} #{self.to_human_time}"
	end

end
