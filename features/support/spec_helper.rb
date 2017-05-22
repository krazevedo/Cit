# encoding: utf-8
# !/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '../pages/*.rb')].each { |file| require file }

module Ryanair
  module Pages
    def home
      Ryanair::Pages::HomePage.new
    end

    def login
      Ryanair::Pages::LoginPage.new
    end

    def booking
      Ryanair::Pages::BookingHomePage.new
    end

    def seat
      Ryanair::Pages::SeatsPage.new
    end

    def extra
      Ryanair::Pages::ExtrasPage.new
    end

    def payment
      Ryanair::Pages::PaymentPage.new
    end
  end
end
