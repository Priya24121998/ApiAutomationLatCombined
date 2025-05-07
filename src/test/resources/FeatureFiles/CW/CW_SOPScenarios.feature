Feature: CW SOP  Scenarios

  @CWSop_Reg
  Scenario: [GDC-3424] Verify that error message appears in API response when retrieve the SOP Request with Invalid Basesite ID
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And I Hit SOP Request API
      | baseSiteId | cengage-b2c-wfs-us1 |
      | cartId     | Valid               |
      | status     |                 400 |
    Then I verify SOP error
      | error | invalidBaseSiteId |

  @CWSop_Reg
  Scenario: [GDC-3423] Verify that error message appears in API response when retrieve the SOP Request with Invalid Cart ID.
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And I Hit SOP Request API
      | baseSiteId | cengage-b2c-wfs-us |
      | cartId     | invalid            |
      | status     |                400 |
    Then I verify SOP error
      | error | InvalidCartId |

  @CWSop_Reg
  Scenario: [GDC-3422] Verify that error message appears in API response when retrieve the SOP Response with Invalid Basesite ID.
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-wfs-us1 |
      | cartId     | Valid               |
      | status     |                 400 |
    Then I verify SOP error
      | error | invalidBaseSiteId |

  @CWSop_Reg
  Scenario: [GDC-3421] Verify that error message appears in API response when retrieve the SOP Response with Invalid Cart ID.
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-wfs-us |
      | cartId     | invalid            |
      | status     |                400 |
    Then I verify SOP error
      | error | InvalidCartId |

  @CWSop_Reg @CWSop_Smoke
  Scenario: [GDC-3420] Verify that commerce payment API SOP Response will work with system to system authentication based on System Token (NOT user token)
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-wfs-us |
      | cartId     | Valid              |
      | status     |                200 |
    Then I verify SOP api response
      | cardType       | visa           |
      | expiryYear     |           2026 |
      | subscriptionId | subscriptionId |
      | billingAddress | Pennsylvania   |

  @CWSop_Reg
  Scenario: [GDC-10482] [CW] Verify that Reason code '201' appears in the SOP response API and Place Order API when the user has added an invalid credit card number while adding payment details using the CyberSource URL.
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-wfs-us |
      | cartId     | Valid              |
      | status     |                400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-wfs-us |
      | status    |                400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-10482 and Cart details

    #scenario_removed
  Scenario: [GDC-12834] [CW] Verify that API should returns '400' status code in SOP response API response with error message if skipping the CyberSource details.
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                150 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                201 |
    Then I Add Billing Address to Pennsylvania
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-wfs-us |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    And Test Data for GDC-12834 and Cart details
