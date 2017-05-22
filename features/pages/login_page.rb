# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Pages
    class LoginPage < SitePrism::Page
      element :login_field, :field, 'Email address'
      element :password_field, :field, 'Password'
      element :sign_in, 'button[class=core-btn-primary]'

      def with(user, pwd)
        login_field.set user
        password_field.set pwd
        sign_in.click
      end
    end
  end
end
