#Feature: Rental Tax Calculation
#
#
  #CU24
  #@Rental_TaxCalculation
  #Scenario:Verify tax calculation for CU-24 rental purchased using CC
    #Given Create CU24RentalTax020 user 
    ##Given I open cengage commerce page
    ##And Add product to cart
    #When I purchase 24Mon_SKU subscription plan through API
    #Then I verify get state API response value of subscriptionPlan field is Full-Access-730
    #When I Hit the API to add cart to user account and verify status code
    #And User adds cuRental_5 product to cart
    #And User adds NonTaxable_Address to delivery address
    #And Add NonTaxable_Address to billing address
    #Then I get delivery modes
    #Then I put standard-us as shipping mode
    #And User launches CyberSource
    #And User Enters Visa card details
    #Then User verifies ACCEPT message
    #Then User place order and verify status code
    #Then User get order details
    #Then Verify Tax appears as 0.0
    #And I log Test Data for discountedRentals
    ##When I click on sidebar sign out button
