Feature: B2C CA Order Scenarios

  #################################################  Smoke   ################################################################
  @B2C_CA_Order_Smoke2
  Scenario: [GDC-9969] Verify that the user is able to place an order using Credit card [Visa]
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for GDC-9969 and order details

  @B2C_CA_Order_Smoke2
  Scenario: [GDC-9965] Verify the tax is getting calculated for Ebook/Bundle/Shippable products for taxable address.
    When I hit get order details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify following details in API response
      | totalTax.value | 6.85 |
    And Test Data for GDC-9965 and order details

  @B2C_CA_Order_Smoke
  Scenario: [GDC-9967] Verify that the user is able to place an order using PayPal.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-ca |
      | status    |            200 | 
    And Test Data for GDC-9967 and order details
    #---------------------Old paypal---------------------#
    #And I launch paypal for B2C stores
      #| basestore | cengage-b2c-ca |
      #| status    |            200 |
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I hit api to place B2C order using Paypal
      #| basestore | cengage-b2c-ca |
      #| status    |            200 |
    #

  @B2C_CA_Order_Smoke
  Scenario: [GDC-9972] Verify that the user is not able to place an order without providing the payment details.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-9972 and Cart details

  @B2C_CA_Order_Smoke
  Scenario: [GDC-9964] Verify user is able to checkout different types of products together. for eg: physical, digital, bundle products
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | caEbook_1      |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | bundle_1       |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Master card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for GDC-9964 and order details

  #################################################  Reggression   ###########################################################
  @B2C_CA_Order
  Scenario: [GDC-10273] Verify that user can purchase shippable product with same Delivery and Billing address.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for SAPECOMM-9310 and order details

  @B2C_CA_Order
  Scenario: [GDC-10264] Verify that user can purchase shippable product with diff Delivery and Billing address.
    #Verify that the user is able to place an order using Credit card [Master]
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address2    |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Master card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And Test Data for SAPECOMM-9309 and order details

  @B2C_CA_Order
  Scenario: [GDC-10293] Verify that the user is able to place an order using Credit card [Master]
    When I hit get order details API
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    And Test Data for SAPECOMM-9251 and order details

  @B2C_CA_Order
  Scenario: [GDC-10280] Verify that the user is not able to place an order with providing the incorrect payment details.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Invalid card details
    Then User verifies ERROR message
    Then User place order for B2C cart
      | basestore | cengage-b2c-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for SAPECOMM-9257 and Cart details

  @B2C_CA_Order
  Scenario: [GDC-10288] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice.
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | bundle_1       |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-ca |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place B2C order with special shipping Instruction
      | basestore                   | cengage-b2c-ca                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 08/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                201 |
    And Test Data for SAPECOMM-9287 and order details

  # ERP PHASE 2 TICKET - ADDED NEWLY
  @sapecomm-11252 @B2C_CA_Order_Reg
  Scenario: [GDC-12886] Verifying the Paypal full Authentication scenario for B2C CA
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_2   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-ca |
      | status    |            200 |


  @sapecomm-11252 @B2C_CA_Order_Reg
  Scenario: [GDC-12889] Verifying the Paypal full Authentication scenario for B2C CA With Promo Code
    Given I Hit Api to create B2CCA Token
    Given I hit API to create B2CCA user
    When I hit API to create B2CCA cart
      | basestore | cengage-b2c-ca |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-ca |
      | Product   | b2cProduct_7   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-ca |
      | address   | CA_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-ca |
      | mode      | standard-ca    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-ca |
      | voucherID | B2CCA_50       |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-ca |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-ca |
      | status    |            200 |
  #Scenario: [GDC-10287] Verify that each address line 1 and 2 can be of size more than  40 characters in billing and delivery address and place order.
    #Given I Hit Api to create B2CCA Token
    #Given I hit API to create B2CCA user
    #When I hit API to create B2CCA cart
      #| basestore | cengage-b2c-ca |
      #| status    |            201 |
    #And User add B2C products to cart
      #| basestore | cengage-b2c-ca |
      #| Product   | b2cProduct_1   |
      #| status    |            200 |
    #And User adds billing address to cart
      #| basestore | cengage-b2c-ca |
      #| address   | CA_addressG40  |
      #| status    |            201 |
    #When User adds delivery address to cart
      #| basestore | cengage-b2c-ca |
      #| address   | CA_addressG40  |
      #| status    |            201 |
    #Then User gets all delivery modes
      #| basestore | cengage-b2c-ca |
      #| status    |            200 |
    #When User puts delivery mode
      #| basestore | cengage-b2c-ca |
      #| mode      | standard-ca    |
      #| status    |            200 |
    #And I launch dummy CyberSource
      #| basestore | cengage-b2c-ca |
    #And User Enters Master2 card details
    #Then User verifies ACCEPT message
    #Then User place order for B2C cart
      #| basestore | cengage-b2c-ca |
      #| status    |            201 |
    #And Test Data for SAPECOMM-9284 and order details
