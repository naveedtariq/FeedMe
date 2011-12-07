namespace :db do

	desc "Add FAQ's"
	task :faqs => :environment do
		Faq.create({:question => 'Why order through Food Court?', :answer => 'At Food Court we offer the most efficient and enjoyable online food ordering experience. You will completely eliminate hold time on the phone as well as communication errors with your order. The restaurant will be able to see your order exactly as you like it. Not to mention we are the online food ordering service that is on Facebook!'})
		Faq.create({:question => 'Which restaurants deliver to me?',:answer => 'After typing in your address and clicking on the delivery tab, you will be directed to the restaurant page where all the restaurants that deliver to you will appear.\n\nShould you click on pick-up ALL restaurants within your area will show.'})
		Faq.create({:question => 'How do I place an order?',:answer => 'After selecting delivery or pick up, a list of restaurants will appear where you will choose which restaurant you would like. From there you will be directed to their menu. You will then choose whatever items you would like to eat and add them to your shopping cart. Proceed by clicking the "checkout" button. After doing so, you will be asked to give your credit card information and other relevant personal information. You will then click "place order" and the information will be submitted to the restaurant for your order to be processed.'})
		Faq.create({:question => 'How do I know that my order has been processed?',:answer => 'You will receive an email confirming the order within 10 minutes, should you not receive the email the order has NOT been processed. \n\nIf you do not receive an email within 10 minutes of placing your order, then the order did not go through and you should contact the restaurant.'})
		Faq.create({:question => 'What if I do get a confirmation email but the food is never delivered to me?',:answer => 'It is the restaurants obligation to fulfill all orders. Proceed by calling the restaurant. You may also notify Food Court who will work with the restaurant to prevent this from happening again. <b>It is the restaurants duty, to fulfill all orders placed though Food Court.</b>\n\nYou can email us at <a href=''mailto:info@foodcourtapp.com''>info@foodcourtapp.com</a>'})
		Faq.create({:question => 'Is there an extra charge from ordering through Food Court?',:answer => 'No, Food Court does not add on any additional convenience fees aside from what the restaurant may charge.'})
		Faq.create({:question => 'What if I do not see a restaurant that I like?',:answer => 'Click on the "Restaurant" tab or email us at <a href=''mailto:info@foodcourtapp.com''>info@foodcourtapp.com</a>. The food court team will do everything in its'' power to make this restaurant available to you in the future. '})
		Faq.create({:question => 'If I realize in the middle of my order that I want delivery instead of pick up, can I switch?',:answer => 'Yes, there is a tab within your shopping cart that allows you to do so. However, switching from pick-up to delivery may or may not be available because your location may not be within the delivery parameters of the restaurant. If the change is not possible, you will then be notified that the restaurant you have chosen does not in fact deliver to your location, at which point you would  have to the food delivery process over again. '})
	end


	task :update_faqs => :environment do
    Faq.delete_all
		Faq.create({:question => 'Why order through FeedMe?', :answer => 'At FeedMe we offer the most efficient and enjoyable online food ordering experience. You will completely eliminate hold time on the phone as well as communication errors with your order. The restaurant will be able to see your order exactly as you like it. Not to mention we are the online food ordering service that is on Facebook!'})
		Faq.create({:question => 'Which restaurants deliver to me?',:answer => 'After typing in your address and clicking on the delivery tab, you will be directed to the restaurant page where all the restaurants that deliver to you will appear.\n\nShould you click on pick-up ALL restaurants within your area will show.'})
		Faq.create({:question => 'How do I place an order?',:answer => 'After selecting delivery or pick up, a list of restaurants will appear where you will choose which restaurant you would like. From there you will be directed to their menu. You will then choose whatever items you would like to eat and add them to your shopping cart. Proceed by clicking the "checkout" button. After doing so, you will be asked to give your credit card information and other relevant personal information. You will then click "place order" and the information will be submitted to the restaurant for your order to be processed.'})
		Faq.create({:question => 'How do I know that my order has been processed?',:answer => 'You will receive an email confirming the order within 10 minutes, should you not receive the email the order has NOT been processed. \n\nIf you do not receive an email within 10 minutes of placing your order, then the order did not go through and you should contact the restaurant.'})
		Faq.create({:question => 'What if I do get a confirmation email but the food is never delivered to me?',:answer => 'It is the restaurants obligation to fulfill all orders. Proceed by calling the restaurant. You may also notify FeedMe who will work with the restaurant to prevent this from happening again. <b>It is the restaurants duty, to fulfill all orders placed though FeedMe.</b>\n\nYou can email us at <a href=''mailto:info@fbfeedme.com''>info@fbfeedme.com</a>'})
		Faq.create({:question => 'Is there an extra charge from ordering through FeedMe?',:answer => 'No, FeedMe does not add on any additional convenience fees aside from what the restaurant may charge.'})
		Faq.create({:question => 'What if I do not see a restaurant that I like?',:answer => 'Click on the "Restaurant" tab or email us at <a href=''mailto:info@fbfeedme.com''>info@fbfeedme.com</a>. The food court team will do everything in its'' power to make this restaurant available to you in the future. '})
		Faq.create({:question => 'If I realize in the middle of my order that I want delivery instead of pick up, can I switch?',:answer => 'Yes, there is a tab within your shopping cart that allows you to do so. However, switching from pick-up to delivery may or may not be available because your location may not be within the delivery parameters of the restaurant. If the change is not possible, you will then be notified that the restaurant you have chosen does not in fact deliver to your location, at which point you would  have to the food delivery process over again. '})
	end

end
