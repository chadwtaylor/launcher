class ReserveMailer < ActionMailer::Base
	helper ApplicationHelper

	default from: "NeverFold <support@neverfold.com>"

	def reserved(order)
		@order = order
		mail(to: order.person.email, subject: "Thank you for your pledge")
	end

end