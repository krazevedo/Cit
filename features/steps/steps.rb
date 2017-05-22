


# Given(/^i have a login$/) do |table|
#   @user = table.hashes[0]['username']
#   @pwd = table.hashes[0]['password']
# end

# When(/^do login$/) do
#   login.with(@user, @pwd)
# end

# Then(/^i see the message$/) do |message|
#   page.should have_content message
# end

Given(/^i visit the Ryanair Page$/) do
  home.load
  home.login_button.click
  login.with(ENV['user'], ENV['password'])
end

Given(/^I make a booking from "([^"]*)" to "([^"]*)"$/) do |departure, destination|
  home.select_destination(destination)
  home.continue  
end

Given(/^Choose Fly out "([^"]*)" and back "([^"]*)"$/) do |dateout, dateto|
  home.select_period(dateout, dateto)  
end

Given(/^Choose "([^"]*)" "([^"]*)"$/) do |qtd, type|
  home.select_passengers(qtd.to_i, type)  
end

Given(/^Choose seats and fill passengers informations$/) do 
  home.letsgo
  booking.select_flights
  seat.select_seats_from
  seat.select_seats_to
  seat.confirm_seats
  extra.checkout
  payment.fill_passengers
  payment.fill_contact_details  
  binding.pry
end

When(/^I pay for booking with invalid card$/) do    
  payment.fill_card_details
  payment.fill_adress
  payment.accept_policies
end

Then(/^I should get payment declined message$/) do
  payment.payments.wait_for_error_title
  expect(payment.payments.error_title.text).to eq("Oh. There was a problem")
  expect(payment.payments.error_text.text).to eq("As your payment was not authorised we could not complete your reservation. Please ensure that the information was correct or use a new payment to try again")
end