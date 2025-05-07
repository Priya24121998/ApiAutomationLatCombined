Feature: CW - Tax Calculation

  @Tax_Smoke
  Scenario: [GDC-3620] Verify that Tax is Removed, when user update the shipping address for an existing cart for tax free States.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I update Shipping Address to Alaska
    Then I verify Tax is Not calculated For Non Taxable state

  #########################################################Regression#####################################################################
  @Tax_Reg
  Scenario: [GDC-3587] Verify that Tax is also Updated when user update the shipping address for an existing cart.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I get taxValue from response
    Then I update Shipping Address to Pennsylvania
    Then I compare old cart taxValue to new cart taxValue

  @Tax_Reg
  Scenario: [GDC-3616] Verify that user is able to Create Cart for US-CA and tax is Properly calculated.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | California        |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to California
    Then I hit api to validate cart response
    Then I hit api to get cart response

  @Tax_Reg
  Scenario: [GDC-3473] Verify that when user creating a cart only 6% tax is applicable to the taxable portion for LOAN PROVIDER payer model.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | addressType                  | Pennsylvania      |
      | productCode                  | CONTAINER_PRODUCT |
    Then I verify Tax amount For Taxable state

  @Tax_Reg
  Scenario: [GDC-3472] Verify that when user creating a cart only 6% tax is applicable to the taxable portion for PARTNER payer model.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | PARTNER           |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state

  @Tax_Reg
  Scenario: [GDC-3471] Verify that when user creating a cart only 6% tax is applicable to the taxable portion for SELF payer model.
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

  @Tax_Reg
  Scenario: [GDC-3588] Verify that Tax is calculated based upon the shipping address of cart.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I get taxValue from response
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Indiana           |
    Then I compare old cart taxValue to new cart taxValue

  @Tax_Reg
  Scenario: [GDC-3617] Verify that user is able to Create Cart and No tax Sholud be calculated for tax free States.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Alaska            |
    Then I verify Tax is Not calculated For Non Taxable state
