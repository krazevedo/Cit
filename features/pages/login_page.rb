# encoding: utf-8
# !/usr/bin/env ruby
require 'site_prism'

module Ryanair
  module Sections
    class Login < SitePrism::Section      
      element :login_field, :field, 'Email address'
      element :password_field, :field, 'Password'
      element :sign_in, 'button[class=core-btn-primary]'
    end
  end
  module Pages
    class LoginPage < SitePrism::Page
      section :login, Ryanair::Sections::Login, '.modal-form-container'

      def with(user, pwd)
        sleep(1)
        login.login_field.set user
        login.password_field.set pwd
        login.sign_in.click
      end
    end
  end
end
