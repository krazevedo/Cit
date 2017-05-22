# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class Flights < SitePrism::Section      
      element :from, :field, 'Departure airport'
      element :to, :field, 'Destination airport'
      element :continue, 'button', text: 'Continue'
      element :letsgo, 'button', text: 'Let\'s go!'
    end
  end
  module Sections
    class DatesFrom < SitePrism::Section      
      element :flyout, 'label', text:'Fly out:'
      element :day, 'input[class^=dd]'
      element :month, 'input[class^=mm]'
      element :year, 'input[class^=yyyy]'
      element :flyto, 'label', text:'Fly back:'      
    end
  end
  module Sections
    class DatesTo < SitePrism::Section      
      element :flyto, 'label', text:'Fly back:'      
      element :day, 'input[class^=dd]'
      element :month, 'input[class^=mm]'
      element :year, 'input[class^=yyyy]'      
    end
  end
  module Sections
    class Passengers < SitePrism::Section      
      element :select, 'div.dropdown-handle'
      elements :button, 'button'      
    end
  end
  module Sections
    class Popup < SitePrism::Section      
      element :continue, 'button', text: 'Continue to search'
    end
  end  
  module Pages
    class HomePage < SitePrism::Page
      set_url '/'
      section :flights, Ryanair::Sections::Flights, '.search-container'
      section :datesfrom, Ryanair::Sections::DatesFrom, '.container-from'
      section :datesto, Ryanair::Sections::DatesTo, '.container-to'
      section :passengers, Ryanair::Sections::Passengers, '.col-passengers'
      section :popup, Ryanair::Sections::Popup, '.promo-popup-benefits.family'
      element :body, 'body'
      element :login_button, 'li#myryanair-auth-login'
      $total, $adults, $children, $teens, $infants = 0,0,0,0,0

      def select_destination(destination) 
        sleep(0.5)
        flights.to.set(destination)
        flights.continue.click
      end

      def continue
        sleep(1)
        flights.continue.click
      end

      def select_period(dateout, dateto)
        sleep(0.5)
        dateout = Date.parse dateout
        dateto = Date.parse dateto
        datesfrom.flyout.click
        datesfrom.day.set(dateout.strftime("%d"))
        datesfrom.month.set(dateout.strftime("%m"))
        datesfrom.year.set(dateout.strftime("%Y"))
        datesto.flyto.click
        datesto.day.set(dateto.strftime("%d"))
        datesto.month.set(dateto.strftime("%m"))
        datesto.year.set(dateto.strftime("%Y"))
      end

      def select_passengers(qtd, type)
        $total += qtd
        case type
          when "adults", "adult"
            $adults += qtd
            qtd = qtd - 1
            bt = 1
          when "teens", "teen"
            $teens += qtd
            bt = 3
          when "children", "child"
            $children = qtd
            bt = 5
          when "infants", "infant"
            $infants += qtd
            bt = 7
          else bt = 1
        end
        sleep(0.5)
        passengers.select.click
        page.execute_script('window.scrollTo(0,300)')
        passengers.button[bt].click
        passengers.select.click             
      end

      def letsgo
        sleep(1)
        flights.letsgo.click
        popup.continue.click
      end
    end
  end
end
