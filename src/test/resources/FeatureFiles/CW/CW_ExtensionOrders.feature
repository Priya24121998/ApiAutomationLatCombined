Feature: CW Extension Scenarios

  @Extension_Smoke
  Scenario: [GDC-3559] Extension: Verify that student is able to extend product duration through API
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
    When I hit API to create WFS Extension Cart
      | orderType                    | EXTENSION |
      | studentUpfrontPaymentPortion |         30 |
      | taxToBePaidUpfront           | true      |
      | payerModel                   | SELF      |
      | paymentFrequency             | ONE_TIME  |
      | addressType                  | Hawaii    |
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify consignment entry status to EXTENDED

  @Extension_Reg
  Scenario: [GDC-3219] Verify user is able to create a cart to extend the duration of a course.
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
    When I hit API to create WFS Extension Cart
      | orderType                    | EXTENSION |
      | studentUpfrontPaymentPortion |         30 |
      | taxToBePaidUpfront           | true      |
      | payerModel                   | SELF      |
      | paymentFrequency             | ONE_TIME  |
      | addressType                  | Hawaii    |
    Then I verify EXTENSION cart is created successfully

  @Extension_Reg 
  Scenario: [GDC-3574] Verify that user should get an error if user try to extend product without providing payment
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
    When I hit API to create WFS Extension Cart
      | orderType                    | EXTENSION |
      | studentUpfrontPaymentPortion |         30 |
      | taxToBePaidUpfront           | true      |
      | payerModel                   | SELF      |
      | paymentFrequency             | ONE_TIME  |
      | addressType                  | Hawaii    |
    Then I Add Billing Address to Hawaii
    Then Place CW order Without payment details

  @Extension_Reg
  Scenario: [GDC-3573] Verify that Existing registration id will continue for extension
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
    And I get registration key
    Then I create consignment
    When I hit API to create WFS Extension Cart
      | orderType                    | EXTENSION |
      | studentUpfrontPaymentPortion |       30 |
      | taxToBePaidUpfront           | true      |
      | payerModel                   | SELF      |
      | paymentFrequency             | ONE_TIME  |
      | addressType                  | Hawaii    |
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify regKey is not changed
        
 @Extension_Reg
  Scenario: [GDC-3570] Extension: Verify that user should be able to re-extend the product
  	And I get registration key
  	Then I create consignment
    When I hit API to create WFS Extension Cart
      | orderType                    | EXTENSION |
      | studentUpfrontPaymentPortion |       60 |
      | taxToBePaidUpfront           | true      |
      | payerModel                   | SELF      |
      | paymentFrequency             | ONE_TIME  |
      | addressType                  | Hawaii    |
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify regKey is not changed

