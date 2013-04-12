$ ->
	
	card = parse_card_data($('form.form_credit_card'))
	card.number.payment('formatCardNumber') # formatCardNumber()
	card.exp_mm.payment('restrictNumeric') # restrictNumeric()
	card.exp_yy.payment('restrictNumeric') # restrictNumeric()
	card.cvc.payment('formatCardCVC')

	$('form.form_credit_card .button').click ->

		flash_reset()

		form = $(this).parents('form') 
		card = parse_card_data(form)

		unless $.payment.validateCardNumber(card.number.val())
			flash_message("Card number is not valid")
			card.number.addClass('error')
			$(this).fadeTo(100, .25)
			return

		unless $.payment.validateCardExpiry(card.exp_mm.val(), card.exp_yy.val())
			flash_message("Expiration date is not valid")
			card.exp_mm.addClass('error')
			card.exp_yy.addClass('error')
			return

		unless $.payment.validateCardCVC(card.cvc.val(), $.payment.cardType(card.number.val()))
			flash_message("CVC Code is not valid")
			card.cvc.addClass('error')
			return

		$(this).fadeTo(100, .25)
		#$(form).submit()
		form.submit()

window.parse_card_data = (form) ->
	card = {}
	card.number = form.find('#card_number')
	card.exp_mm = form.find('#card_expire_month')
	card.exp_yy = form.find('#card_expire_year')
	card.cvc = form.find('#card_cvc')
	card.full_name = form.find('#card_full_name')
	return card




