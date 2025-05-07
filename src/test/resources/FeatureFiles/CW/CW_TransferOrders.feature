Feature: CW Transfer Scenarios

  @Transfer_Smoke
  Scenario: [GDC-2882] Transfer: Verify that student is able to transfer one product to another through API
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    When I hit API to create WFS Transfer Cart
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | SELF     |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      201 |
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

  @Transfer_Reg
  Scenario: [GDC-2881][GDC-3572] Verify that RegistrationKey, oldRegistrationKey is fetched in response of the order placed for the Transfer
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    When I hit API to create WFS Transfer Cart
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | SELF     |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      201 |
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify old and New registration key in order details
    Then I verify consignment entry status to TRANSFERRED
    
    @Transfer_Reg 
  Scenario: [GDC-3571] Transfer: User should get an error when user is trying re-transfer the order once after it's already transferred
   And I try to re-transfer the order
   Then I verify user is unable to transfer product
   |error|reTransfer|

  @Transfer_Reg
  Scenario: [GDC-2880][GDC-3584] Verify that user is unable to transfer product when Consignment Entry Status is Fulfilled
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    Then I verify consignment entry status to FULFILLED
    When I hit API to create WFS Transfer Cart
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | SELF     |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      400 |
    Then I verify user is unable to transfer product
    |error|Fulfilled|

  @Transfer_Reg
  Scenario: [GDC-3214] Verify that user is able to create a cart for transfer of a course.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    When I hit API to create WFS Transfer Cart
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | SELF     |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      201 |
    Then I verify TRANSFER cart is created successfully

  @Transfer_Reg
  Scenario: [GDC-3217] Verify that user is able to create a cart for transfer of a course purchased by partner.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | PARTNER           |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    When I hit API to create WFS Transfer Cart
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | PARTNER  |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      201 |
    Then I verify TRANSFER cart is created successfully

  @Transfer_Reg
  Scenario: [GDC-3562] Verify that user should not be able to create a cart for transfer of a course if "originalCommerceOrderID" is empty.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    When Create transfer cart without original orderId
      | orderType                    | TRANSFER |
      | studentUpfrontPaymentPortion |        0 |
      | taxToBePaidUpfront           | true     |
      | payerModel                   | SELF     |
      | paymentFrequency             | ONE_TIME |
      | addressType                  | Hawaii   |
      | status                       |      400 |
    Then verify non-empty originalCommerceOrderId error is thrown

  @Transfer_Reg 
  Scenario: [GDC-3563] Verify that a cancelled consignments entries can not be cancelled again
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    Then I verify registration can not cancelled again

  @Transfer_Reg
  Scenario: [GDC-3561] Verify that user should not be able to cancel consignments entries with an Invalid registration number
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And Cancel consignment with invalid registration key
    Then I verify cancel consignment Error

