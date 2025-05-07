Feature: B2C AU Delivery Cost API Scenarios

  #################################################  Smoke   ################################################################

  @B2C_AU_DelCost_Smoke
  Scenario: [GDC-9957] Verify that user has to pay delivery cost $0.00 if user purchases product equals to or more than $200(Physical Book).
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
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-9957 and Cart details

  @B2C_AU_DelCost_Smoke
  Scenario: [GDC-9956] Verify that user has to pay delivery cost $11.00 if user purchases product less than $200(Physical Book).
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au  |
      | Product   | AUb2cPhysical_2 |
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
    And I verify delivery cost is 11.0
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 11 |
    And Test Data for GDC-9956 and Cart details
    
     @B2C_AU_DelCost_Smoke
  Scenario: [GDC-9953] Verify total price is recalculated after setting the delivery mode using get cart API
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
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value | 92.95 |
      | subTotal.value   | 92.95 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-au |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | totalPrice.value   | 103.95 |
      | subTotal.value     |  92.95 |
      | deliveryCost.value |     11 |
    And Test Data for GDC-9953 and Cart details
    

  #################################################  Reggression   ###########################################################
  @B2C_AU_DelCost
  Scenario: [GDC-10256] Verify that user is charged with $0 if user purchases Physical + Digital Products for more than $200 in total
    Given I Hit Api to create B2CAU Token
    Given I hit API to create B2CAU user
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_Mul |
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
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-au |
      | mode      | standard-au    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-au |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-10256 and Cart details

  @B2C_AU_DelCost
  Scenario: [GDC-10230] Verify that API return Country assoicted with shipping address
    Given I Hit Api to create B2CAU Token
    And I hit API to get a list countries
      | basestore | cengage-b2c-au |
      | type      | SHIPPING       |
      | status    |            200 |
    Then I verify following details in API response
      | countries[0].isocode | AU        |
      | countries[0].name    | Australia |

  @B2C_AU_DelCost
  Scenario: [GDC-10245] Verify that API return State assoicted with shipping address
    Given I Hit Api to create B2CAU Token
    And I hit API to get states assosiated with country
      | basestore   | cengage-b2c-au |
      | countryCode | AU             |
      | status      |            200 |
    Then I verify states in API response
      | AU-ACT | Australian Capital Territory |
      | AU-NSW | New South Wales              |
      | AU-NT  | Northern Territory           |
      | AU-QLD | Queensland                   |
      | AU-SA  | South Australia              |
      | AU-TAS | Tasmania                     |
      | AU-VIC | Victoria                     |
      | AU-WA  | Western Australia            |

  @B2C_AU_DelCost
  Scenario: [GDC-10255] Verify that user is charged with $0 if purchase is more or less than $200 (digital product).
    Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_3   |
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
    And I verify delivery cost is 0.0
    Given I Hit Api to create B2CAU Token
    When I hit API to create B2CAU cart
      | basestore | cengage-b2c-au |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-au |
      | Product   | b2cProduct_4   |
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
    And I verify delivery cost is 0.0
    And Test Data for GDC-10255 and Cart details

 
