Feature: CW Regression Scenarios

  @CW_Regression
  Scenario: [GDC-3430] Verify the error message appears when user tries to update billing address with invalid BaseSite id.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address with invalid BaseSite id

  @CW_Regression
  Scenario: [GDC-3299] Verify the error message appears when user tries to update billing address with invalid cart id.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address with invalid cart id

  @CW_Regression
  Scenario: [GDC-3288] Verify that user is able to place order with required fields in reponse
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify required fields in order response

  # Duplicate
  #Scenario: [GDC-3219] Verify user is able to create a cart to extend the duration of a course.
  #Given I hit API to create WFS token
  #When I hit API to create WFS Cart
  #| orderType                    | NEW         |
  #| studentUpfrontPaymentPortion |         100 |
  #| taxToBePaidUpfront           | true        |
  #| payerModel                   | SELF        |
  #| paymentFrequency             | ONE_TIME    |
  #| paymentMethod                | CREDIT_CARD |
  #| productCode                  | CONTAINER_PRODUCT |
  #| addressType                  | Hawaii      |
  #Then I verify Tax amount For Taxable state
  #Then I Add Billing Address to Hawaii
  #And launch CW CyberSource
  #And User Enters Visa card details
  #Then User verifies ACCEPT message
  #Then Place CW order and verify status code
  #Then I create consignment
  #When I hit API to create WFS Extension Cart
  #| orderType                    | EXTENSION      |
  #| studentUpfrontPaymentPortion |        0 |
  #| taxToBePaidUpfront           | true     |
  #| payerModel                   | SELF     |
  #| paymentFrequency             | ONE_TIME |
  #| addressType                  | Hawaii   |
  #Then I verify EXTENSION cart is created successfully
  @CW_Regression
  Scenario: [GDC-3450] Verify that user is not able to create the cart if shipping address is removed from the cart..
    Given I hit API to create WFS token
    When I hit API to create WFS Cart with Empty Delivery Address
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Empty             |
    Then verify Cart is not Created Without delivery Address

  @CW_Regression
  Scenario: [GDC-3590] Verify that Api Throws Proper Error message when No payload is provided.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Empty
    Then I verify Address error for EmptyBilling

  #And I Update delivary Address to Empty
  #Then I verify Address error for Empty
  
  
  #Scenario: [GDC-3589] Verify that Api Throws Proper Error message when entered unsupported delivery Country.
    #Given I hit API to create WFS token
    #When I hit API to create WFS Cart
      #| orderType                    | NEW               |
      #| studentUpfrontPaymentPortion |               100 |
      #| taxToBePaidUpfront           | true              |
      #| payerModel                   | LOAN_PROVIDER     |
      #| paymentFrequency             | ONE_TIME          |
      #| paymentMethod                | CREDIT_CARD       |
      #| productCode                  | CONTAINER_PRODUCT |
      #| addressType                  | InvalidIsd        |
    #Then I verify Tax amount For Taxable state
    #Then I Add Billing Address to Pennsylvania
    #Then I hit api to get cart response
    #Then I Add Billing Address with invalid Isd code
    #Then I verify the error for invalid ISD code

