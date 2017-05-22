# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class Outbound < SitePrism::Section      
      element :flight, 'div[class=core-btn-primary]'
      elements :select, 'button', text: 'Select'      
    end
  end
  module Sections
    class Inbound < SitePrism::Section      
      element :flight, 'div[class=core-btn-primary]'
      elements :select, 'button', text: 'Select'      
    end
  end
  module Pages
    class BookingHomePage < SitePrism::Page
      section :outbound, Ryanair::Sections::Outbound, '#outbound'
      section :inbound, Ryanair::Sections::Inbound, '#inbound' 
      element :continue, 'button#continue'  

      def select_flights
        sleep(2)
        outbound.flight.click
        sleep(2)
        outbound.select[0].click
        sleep(2)
        inbound.flight.click
        sleep(2)
        inbound.select[0].click
        sleep(1)
        continue.click   
      end
    end
  end
end
