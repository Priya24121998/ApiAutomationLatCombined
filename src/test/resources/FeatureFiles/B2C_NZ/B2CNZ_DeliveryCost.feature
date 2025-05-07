Feature: B2C NZ Delivery Cost API Scenarios

  #################################################  Smoke   ################################################################
  @B2C_NZ_DelCost_Smoke
  Scenario: [GDC-9944] Verify that user has to pay delivery cost $11.00 if user purchases product less than $200(Physical Book).
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 11.0
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 11 |
    And Test Data for GDC-9944 and Cart details

  @B2C_NZ_DelCost_Smoke
  Scenario: [GDC-9943] Verify that user has to pay delivery cost $0.00 if user purchases product equals to or more than $200(Physical Book).
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | NZb2cPhysical_2 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-9943 and Cart details

  #################################################  Reggression   ###########################################################
  @B2C_NZ_DelCost
  Scenario: [GDC-10213] Verify that user is able to get delivery modes using API:
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify some delivery modes
      | codes  |           1 |
      | code_0 | standard-nz |
    And Test Data for GDC-10213 and Cart details

  @B2C_NZ_DelCost
  Scenario: [GDC-10200] Verify that delievry amount is getting calculated after setting the delivery mode using get cart API.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_1   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 11 |
    And Test Data for GDC-10200 and Cart details

  @B2C_NZ_DelCost
  Scenario: [GDC-10202] Verify that user is charged with $0 if user purchases Physical + Digital Products, for more than $200 for physical book
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | b2cProduct_5   |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-10202 and Cart details

  @B2C_NZ_DelCost5
  Scenario: [GDC-10211] Verify that user is charged with $0 if user purchases Physical + Digital Products for more than $200 in total
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | AUb2cPhysical_3 |
      | status    |             200 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz |
      | Product   | NZb2cDigital_3 |
      | status    |            200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 0.0
    When User puts delivery mode
      | basestore | cengage-b2c-nz |
      | mode      | standard-nz    |
      | status    |            200 |
    When I hit get cart details API
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    Then I verify following details in API response
      | deliveryMode.deliveryCost.value | 0 |
    And Test Data for GDC-10211 and Cart details

  @B2C_NZ_DelCost
  Scenario: [GDC-10198] Verify that user should be charged with $11 after applying coupon code to total price which makes total price less than $200.
    Given I Hit Api to create B2CNZ Token
    Given I hit API to create B2CNZ user
    When I hit API to create B2CNZ cart
      | basestore | cengage-b2c-nz |
      | status    |            201 |
    And User add B2C products to cart
      | basestore | cengage-b2c-nz  |
      | Product   | b2cProduct_Mul3 |
      | status    |             200 |
    When User adds delivery address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    And User adds billing address to cart
      | basestore | cengage-b2c-nz |
      | address   | NZ_address     |
      | status    |            201 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 0.0
    When I try to apply vouchers
      | basestore | cengage-b2c-nz |
      | voucherID | B2CNZ_50       |
      | status    |            200 |
    Then User gets all delivery modes
      | basestore | cengage-b2c-nz |
      | status    |            200 |
    And I verify delivery cost is 11.0
    And Test Data for GDC-10198 and Cart details
