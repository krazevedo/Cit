# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
      class TotalCost < SitePrism::Section
        element :checkout, 'button', text: 'Check out'
      end
  end
  module Pages
    class ExtrasPage < SitePrism::Page
      section :totalcost, Ryanair::Sections::TotalCost, '.cart.cart-empty'

      def checkout
        totalcost.checkout.click
      end
    end
  end
end
