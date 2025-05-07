Feature: Standalone Product Purchase

  @StandalonePurchase_Smoke
  Scenario: [GDC-9911] Verify user should be able to purchase bundle
    Given Create standAlnBundle user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Bundle product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |

  @StandalonePurchase_Smoke
  Scenario: [GDC-9920] [eBook+Physical][API] verify that the user is able to place eBook and physical in one go.
    Given Create combinationSmoke8427 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook&Physical product to cart
    Then User fetches cart details
    Then I verify 2 product in cart is Ebook&Physical
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |

    
      @StandalonePurchase_Smoke
  Scenario: [GDC-9907] Verify that user should be able to check-out a digital product cart using paypal
    Given Create DigitalProduct9529 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds Ebook product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-us |
      | status    |            200 |


  ###########################################   [  Reggression  ]    #######################################################
  @StandalonePurchase
  Scenario: [GDC-10134] User should be able to purchase Hardcover/Paperback/Loose Leaf
    Given Create HardCover8279 user 
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds HardCover product to cart
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then User get order details
    And I log Test Data for Normal
    #When I click on sidebar sign out button
    
    
   
