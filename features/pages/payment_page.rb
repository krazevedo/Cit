# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class PassengerDetails < SitePrism::Section
      elements :title, 'select[name^=title]'      
      elements :firstname, :field, 'e.g. John'
      elements :surname, :field, 'e.g. Smith'      
    end
  end
  module Sections
    class ContactDetails < SitePrism::Section      
      element :country, 'select[name=phoneNumberCountry]'
      element :phone, 'input[name=phoneNumber]'            
    end
  end
  module Sections
    class Payments < SitePrism::Section      
      element :cardnumber, :field, 'Enter card number'      
      element :cardtype, 'select[name=cardType]'
      element :month, 'select[name=expiryMonth]'
      element :year, 'select[name=expiryYear]'  
      element :cvv, :field, 'CVV'
      element :cardholder, :field, 'e.g. John Smith' 
      element :adress1, 'input[name=billingAddressAddressLine1'
      element :adress2, 'input[name=billingAddressAddressLine2'
      element :city, 'input[name=billingAddressCity]'  
      element :postcode, 'input[name=billingAddressPostcode]'
      element :country, 'select[name=billingAddressCountry]'
      element :policy, 'input[name=acceptPolicy]'
      element :paynow, 'button', text: 'Pay Now'  
      element :error_title, 'div.info-title'    
      element :error_text, 'div.info-text'        
    end
  end
  module Sections
    class Policy < SitePrism::Section      
      element :policy, 'input'
      element :paynow, 'button', text: 'Pay Now'        
    end
  end
  module Pages
    class PaymentPage < SitePrism::Page
      section :passenger_details, Ryanair::Sections::PassengerDetails, 'ng-form[name=passengersForm]'
      section :contact_details, Ryanair::Sections::ContactDetails, '.after-pax-validation-step'
      section :payments, Ryanair::Sections::Payments, '.payment-form'      
      section :policies, Ryanair::Sections::Policy, '.cta'

      def fill_passengers
        total_adults = $adults + $teens
        my_array = ["Ms", "Mr"] 
        for i in 0..total_adults - 1 do
          passenger_details.title[i].select(my_array.shuffle.first)
          passenger_details.firstname[i].set(Faker::Name.first_name)
          passenger_details.surname[i].set(Faker::Name.last_name)
        end
        total_children = $children + $infants
        for i in 0..total_children - 1 do
          passenger_details.firstname[total_adults + i].set(Faker::Name.first_name)
          passenger_details.surname[total_adults + i].set(Faker::Name.last_name )
        end
      end

      def fill_contact_details
        contact_details.country.select('Brazil')
        contact_details.phone.set(Faker::Number.number(10))
      end

      def fill_card_details
        time = Time.new
        payments.cardnumber.set(Faker::CreditCard.number(:visa, length: 16))
        payments.cardtype.select('Visa')
        payments.month.select(time.month)
        payments.year.select(time.year + 3)
        payments.cvv.set(Faker::Number.number(3))
        payments.cardholder.set(Faker::StarWars.character)
      end

      def fill_adress        
        payments.adress1.set(Faker::Address.street_address)
        payments.adress2.set(Faker::Address.street_address)
        payments.city.set(Faker::Address.city)
        payments.postcode.set(Faker::Address.postcode)
        payments.country.select('Brazil')    
      end

      def accept_policies
        policies.policy(visible: false).click
        policies.paynow.click   
      end
    end
  end
end