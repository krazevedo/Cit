
Feature: Booking

  Background:
    Given i visit the Ryanair Page

  Scenario: Declined payment
    Given I make a booking from "Dublin" to "Lisbon" 
    And Choose Fly out "21/06/2017" and back "24/06/2017" 
    And Choose "2" "adults" 
    And Choose "1" "child"
    And Choose "1" "teen"
    And Choose seats and fill passengers informations
    When I pay for booking with invalid card 
    Then I should get payment declined message
  
