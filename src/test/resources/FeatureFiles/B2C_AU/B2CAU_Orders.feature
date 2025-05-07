Feature: B2C AU Order Scenarios

  #################################################  Smoke   ################################################################
  @B2C_AU_Order_Smoke
  Scenario: [GDC-9950] Verify that user is able to place physical product order using CC [VISA]
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_4 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And Test Data for GDC-9950 and order details

  @B2C_AU_Order_Smoke
  Scenario: [GDC-9961] Verify that user is able to order digital product using Paypal
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | QA_AUb2cDigital_4 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-au |
      | status    |            200 |
    And Test Data for GDC-9961 and order details
    #------------old paypal---------------#
    #And I launch paypal for B2C stores
      #| basestore | cengage-b2c-au |
      #| status    |            200 |
    #Then I verify PayPal portal has launched successfully
    #When I enter paypal login details and make purchase
    #Then I hit api to place B2C order using Paypal
      #| basestore | cengage-b2c-au |
      #| status    |            200 |

  @B2C_AU_Order_Smoke
  Scenario: [GDC-9949] VVerify user is able to checkout Value Pack+physical+digital from single Cart
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cValuePack_1 |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_3 |
      | status    |             200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | AUb2cDigital_2 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And Test Data for GDC-9949 and order details

  #################################################  Reggression   ###########################################################
  @B2C_AU_Order
  Scenario: [GDC-10254] Verify that user should not be able to order without providing payment[CC] details
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    Then User place order for B2C cart
      | basestore | cengage-b2c-au |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-10254 and Cart details

  @B2C_AU_Order
  Scenario: [GDC-10247] Verify if user is able to set collectNumber and specialShippingInstructions during place order API and the same shows in backoffice.
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Master card details
    Then User verifies ACCEPT message
    Then Place B2C order with special shipping Instruction
      | basestore                   | cengage-b2c-au                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 06/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                201 |
    And Test Data for GDC-10247 and order details

  @B2C_AU_Order
  Scenario: [GDC-10231] Verify user is able to checkout Value Pack from the Cart
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cValuePack_1 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch dummy CyberSource
      | basestore | cengage-b2c-au |
    And User Enters Amex card details
    Then User verifies ACCEPT message
    Then Place B2C order with special shipping Instruction
      | basestore                   | cengage-b2c-au                     |
      | collectNumber               |                          285556317 |
      | deferredShipDate            | 06/20/2023                         |
      | specialShippingInstructions | special Shipping Instructions Text |
      | status                      |                                201 |
    And Test Data for GDC-10231 and order details

  @B2C_AU_Order
  Scenario: [GDC-10228] [Partially Automated] Verify that user is able to set specialShippingInstructions during place order API using CC [AMEX] and the same shows in backoffice.
    Given I Hit Api to create B2CAU Token
    When I hit get order details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    And Test Data for GDC-10228 and order details

  # ERP PHASE 2 TICKET - ADDED NEWLY
  @sapecomm-11252 @B2C_AU_Order
  Scenario: [GDC-12887] Verifying the Paypal full Authentication scenario for B2C AU
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_3 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-au |
      | status    |            200 |

  @sapecomm-11252 @B2C_AU_Order
  Scenario: [GDC-12888] Verifying the Paypal full Authentication scenario for B2C AU With Promo Code
>>>>>>> c7ac1a24c674c6648e689fb3168a298e076ccc6f
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_3 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-au |
      | address   | AU_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I try to apply vouchers
      | basestore | cengage-b2c-au |
      | voucherID | B2CAU_50       |
      | status    |            200 |
    And I launch paypal new url for B2C stores
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 30 sec
    Then I hit api to place B2C order using new Paypal workflow
      | basestore | cengage-b2c-au |
      | status    |            200 |
#	 @B2C_AU_Order
  #Scenario: [GDC-10250] Verify that each address line 1 and 2 can be of size more than  40 characters in billing and delivery address and place order.
    #Given I Hit Api to create B2CAU Token
    #Given I hit API to create B2CAU user
    #When I hit API to create B2CAU cart
      #| basestore | cengage-b2c-au |
      #| status    |            201 |
    #And User add B2C products to cart
      #| basestore | cengage-b2c-au |
      #| Product   | b2cProduct_1   |
      #| status    |            200 |
    #And User adds billing address to cart
      #| basestore | cengage-b2c-au |
      #| address   | AU_addressG40  |
      #| status    |            201 |
    #When User adds delivery address to cart
      #| basestore | cengage-b2c-au |
      #| address   | AU_addressG40  |
      #| status    |            201 |
    #Then User gets all delivery modes
      #| basestore | cengage-b2c-au |
      #| status    |            200 |
    #When User puts delivery mode
      #| basestore | cengage-b2c-au |
      #| mode      | standard-au    |
      #| status    |            200 |
    #And I launch dummy CyberSource
      #| basestore | cengage-b2c-au |
    #And User Enters Master2 card details
    #Then User verifies ACCEPT message
    #Then User place order for B2C cart
      #| basestore | cengage-b2c-au |
      #| status    |            201 |
    #And Test Data for GDC-10250 and order details
