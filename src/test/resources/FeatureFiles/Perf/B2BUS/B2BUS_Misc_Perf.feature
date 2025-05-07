Feature: B2B US Misc API Scenarios

  #################################################  Smoke   ################################################################
  @B2B_Misc_Smoke_Perf
  Scenario: [GDC-9926] Verify that user is able set delivery mode again once deleted using API
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
   And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct2  |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | GD                           |
      | status    |                          200 |
    When I hit API to get delivery mode in cart
      | basestore    | cengage-b2b-us               |
      | deliveryMode | GD                           |
      | status       |                          200 |
    Then I hit API to delete delivery modes
      | basestore | cengage-b2b-us |
      | status    |            200 |
    When I hit API to Set  delivery modes
      | basestore | cengage-b2b-us                                 |
      | code      | MS                                             |
      | status    |                                            200 |
    When I hit API to get delivery mode in cart
      | basestore    | cengage-b2b-us                                 |
      | deliveryMode | MS                                             |
      | status       |                                            200 |
    And Test Data for GDC-9926 and Cart details

  @B2B_Misc_Smoke_Perf
  Scenario: [GDC-9932] Verify that user is able to enter different address as a delivery address using drop-ship API:
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2bUsProduct   |
      | status    |            200 |
    When I hit API to get Address details
      | basestore | cengage-b2b-us |
      | town      |   north canton |
      | line1     | 6200 frank ave nw|
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    When I hit API to get Address details
      | basestore | cengage-b2b-us     |
      | town      | Stamford           |
      | line1     | COPIAH-LINCOLN WAY |
      | status    |                200 |
    And Test Data for GDC-9932 and Cart details

  @B2B_Misc_Smoke_Perf
  Scenario: [GDC-9930] Verify tax is calculated after adding the product in cart
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct4  |
      | status    |            200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    When I hit API to get Tax details
      | basestore | cengage-b2b-us |
      | Tax       |           4.12 |
      | status    |            200 |
    And Test Data for GDC-9930 and Cart details

  @B2B_Misc_Smoke_Perf
  Scenario: [GDC-9923] Verify total price is recalculated after setting the delivery mode using get cart API
    Given I Hit Api to create B2BUSNew Token
    When I hit API to create B2BUSNew cart
      | basestore | cengage-b2b-us |
      | status    |            201 |
    And User will call set bill to ship to Put Api in B2BUS store
      | basestore           | cengage-b2b-us |
      | status              |            202 |
    And User add B2B products to cart
      | basestore | cengage-b2b-us |
      | Product   | b2busproduct4  |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |       1     |
      | totalPriceWithTax.value |    not zero |
      | paymentType.code        | CARD        |
      | orderType               | REGULAR     |
    Then I hit API to Set  delivery modes
      | basestore | cengage-b2b-us               |
      | code      | 2D                           |
      | status    |                          200 |
    Then I hit API to Set drop ship address
      | basestore | cengage-b2b-us  |
      | address   | dropShipAddress |
      | status    |             201 |
    When I hit get cart details API
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | totalItems              |       1     |
      | totalPriceWithTax.value |   not zero  |
      | deliveryCost.value      |   0.0       |
      | totalTax.value          |   not zero  |
      | paymentType.code        | CARD        |
      | orderType               | REGULAR     |
    And Test Data for GDC-9923 and Cart details

  #################################################  Smoke   ################################################################
  @B2B_Misc_Perf
  Scenario: [GDC-10179] Verify that user is able to get the B2B UNITS associated with Base store using API
    Given I Hit Api to create B2BUSNew Token
    And I hit API to get units associated with basestore
      | basestore | cengage-b2b-us             |
      | siteId    | cengage-b2b-us?fields=FULL |
      | pageSize  |                         20 |
      | status    |                        200 |
    Then I verify following details in API response
      | pagination.pageSize     |not zero |
      | pagination.totalPages   |   not zero |
      | pagination.totalResults | not zero |

  @B2B_Misc_Perf
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    Given I Hit Api to create B2BUSNew Token
    And I hit b2b user creation API with regex
      | basestore | cengage-b2b-us |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | USERPQA        |
      | status    |            201 |
    Then I verify B2BUS customer is registered


  @B2B_Misc_Perf
  Scenario: [GDC-12857] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2BUSNew Token
    And I need to hit b2b User creation API by passing account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 0100159146      |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PATCH
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @B2B_Misc_Perf
  Scenario: [GDC-12856] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2BUSNew Token
    And I need to hit b2b User creation API by passing account number as a input
      | basestore | cengage-b2b-us |
      | store     | B2BUS          |
      | email     | automation     |
      |account    | 0100159146      |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PUT
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
 
 
  #Scenario: [GDC-10190] Verify that each address line 1 and 2 can be of size more than  40 characters in billing and delivery address and place order.
    #Given I Hit Api to create B2BUS Token
    #When I hit API to create B2B cart
      #| basestore | cengage-b2b-us |
      #| status    |            201 |
    #And User add B2B products to cart
      #| basestore | cengage-b2b-us |
      #| Product   | b2bUsProduct   |
      #| status    |            200 |
    #And User set bill to ship to account number
      #| basestore           | cengage-b2b-us |
      #| shipToAccountNumber |        100114420 |
      #| billToAccountNumber |        100114420 |
      #| status              |            202 |
    #Then User gets all delivery modes
      #| basestore | cengage-b2b-us |
      #| status    |            200 |
    #When I hit API to Set  delivery modes
      #| basestore | cengage-b2b-us               |
      #| code      | GD |
      #| status    |                          200 |
    #Then I hit API to Set drop ship address
      #| basestore | cengage-b2b-us     |
      #| address   | greaterDropShipAdd |
      #| status    |                201 |
    #And I put PO number details using API
      #| basestore | cengage-b2b-us |
      #| PONumber  | PO1234567      |
      #| status    |            200 |
    #And I wait for 50 sec
    #And I launch dummy CyberSource
      #| basestore | cengage-b2b-us |
    #And User Enters Visa card details
    #Then User verifies ACCEPT message
    #Then User place order for B2B cart
      #| basestore | cengage-b2b-us |
      #| status    |            200 |
    #And Test Data for GDC-10190 and order details

