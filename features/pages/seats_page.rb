# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class Popup < SitePrism::Section
     element :button_ok, 'button', text: 'Ok, got it!'   
     element :button_no, 'button', text: 'No, thanks'
    end
  end 
  module Sections
    class PopupPriority < SitePrism::Section
     element :button_no, 'button', text: 'No, thanks'
    end
  end  
  module Sections
    class SeatMap < SitePrism::Section
     elements :standard, 'span.seat-row-seat.standard span'   
    end
  end
  module Pages
    class SeatsPage < SitePrism::Page
      section :seat_map, Ryanair::Sections::SeatMap, '.seat-map-rows'
      section :popup, Ryanair::Sections::Popup, '.seat-map-prompt-content' 
      section :popup_priority, Ryanair::Sections::PopupPriority, '.priority-boarding-prompt'
      element :button_next, 'button', text: 'Next'
      element :confirm, 'button', text: 'Confirm'

      def select_seat
        for i in 0..$total-1 do
          sleep(1)
          seat_map.standard[i].click
        end
        button_next.click
      end
      def select_seats_from
        if $teens > 0 || $children > 0 || $infants > 0
          popup.button_ok.click
        end
        select_seat
      end 
      def select_seats_to
        select_seat
      end

      def confirm_seats
        confirm.click
        if $teens > 0 || $children > 0 || $infants > 0
          sleep(1)
          popup_priority.button_no.click
        end
      end

    end
  end
end
