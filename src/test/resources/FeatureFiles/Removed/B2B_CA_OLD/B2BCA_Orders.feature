Feature: B2B CA Order Scenarios

  #################################################  Smoke   ################################################################
  #################################################  Old Reggression   ###########################################################
  #New
  @B2BCA_Order
  Scenario: [GDC-1001] Verify OCC API: orders throws error with cartId which does not have payment details
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       37722155 |
      | billToAccountNumber |       37722155 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-1001 and Cart details

  @B2BCA_Order_INT
  Scenario: [GDC-1001] Verify OCC API: orders throws error with cartId which does not have payment details
    Given I Hit Api to create B2BCA Token
    When I hit API to create B2BCA cart
      | basestore | cengage-b2b-ca |
      | status    |            201 |
    And User set bill to ship to account number
      | basestore           | cengage-b2b-ca |
      | shipToAccountNumber |       84000381 |
      | billToAccountNumber |       84000381 |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-ca |
      | Product   | b2busproduct2  |
      | status    |            200 |
    Then User gets all delivery modes
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-ca |
      | code      | 0_0_0          |
      | status    |            200 |
    Then User place order for B2B cart
      | basestore | cengage-b2b-ca |
      | status    |            400 |
    Then I verify error with given message
      | Message | CC Payment is failing due to Reason Code |
    And Test Data for GDC-1001 and Cart details
      
      
  #Scenario: [GDC-10465] Verify that user is able to enter different address as a delivery address other than shipTo address.
    #Given I Hit Api to create B2BCA Token
    #When I hit API to create B2BCA cart
      #| basestore | cengage-b2b-ca |
      #| status    |            201 |
    #And User set bill to ship to account number
      #| basestore           | cengage-b2b-ca |
      #| shipToAccountNumber |       84002336 |
      #| billToAccountNumber |       84002335 |
      #| status              |            202 |
    #And User add B2B products to cart
      #| basestore | cengage-b2b-ca |
      #| Product   | b2busproduct2  |
      #| status    |            200 |
    #Then I hit API to Set drop ship address
      #| basestore | cengage-b2b-ca |
      #| address   | CA_address     |
      #| status    |            201 |
    #When I hit API to get Address details
      #| basestore | cengage-b2b-ca  |
      #| town      | Arden           |
      #| line1     | 3171 Reserve St |
      #| status    |             200 |
    #Then I hit API to Set drop ship address
      #| basestore | cengage-b2b-ca |
      #| address   | CA_address2    |
      #| status    |            201 |
    #When I hit API to get Address details
      #| basestore | cengage-b2b-ca    |
      #| town      | La Prairie        |
      #| line1     | 2903 rue St-Henri |
      #| status    |               200 |
    #When I hit API to Set  delivery modes
      #| basestore | cengage-b2b-ca |
      #| code      | 0_0_0          |
      #| status    |            200 |
    #And I put PO number details using API
      #| basestore | cengage-b2b-ca |
      #| PONumber  | b2b-ca-po      |
    #Then User place order for B2B cart
      #| basestore | cengage-b2b-ca |
      #| status    |            200 |
    #And Test Data for GDC-10465 and order details
