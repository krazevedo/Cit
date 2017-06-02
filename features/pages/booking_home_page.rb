# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class Outbound < SitePrism::Section      
      element :flight, 'div[class=core-btn-primary]'
      elements :types, 'button', text: 'Select'      
    end
  end
  module Sections
    class Inbound < SitePrism::Section      
      element :flight, 'div[class=core-btn-primary]'
      elements :types, 'button', text: 'Select'      
    end
  end
  module Pages
    class BookingHomePage < SitePrism::Page
      section :outbound, Ryanair::Sections::Outbound, '#outbound'
      section :inbound, Ryanair::Sections::Inbound, '#inbound' 
      element :continue, 'button#continue'  

      def select_flight_from
        sleep(2)
        outbound.flight.click                
      end

      def select_type_from(type)
        sleep(2)
        case type
          when "standard"
            outbound.types[0].click
          when "leisure"
            outbound.types[1].click
          when "business"
            outbound.types[2].click
          else outbound.types[0].click
        end
      end

      def select_flight_to
        sleep(2)
        inbound.flight.click
      end

      def select_type_to(type)
        sleep(2)
        case type
          when "standard"
            inbound.types[0].click
          when "leisure"
            inbound.types[1].click
          when "business"
            inbound.types[2].click
          else inbound.types[0].click
        end
        sleep(2)
        continue.click
      end
    end
  end
end
