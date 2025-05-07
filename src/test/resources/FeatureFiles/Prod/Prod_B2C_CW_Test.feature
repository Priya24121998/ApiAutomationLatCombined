Feature: 3. Prod B2C CW

  @Prod_B2C_CW
  Scenario: [GDC-3620] Verify that Tax is Removed, when user update the shipping address for an existing cart for tax free States. For e.g Alaska.
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
    Then I verify Tax amount For Taxable State
    Then I update Shipping Address to Alaska
    Then I verify Tax is Not calculated For Non Taxable State

  @Prod_B2C_CW
  Scenario: [GDC-3616] Verify that user is able to create cart for taxable state and tax is Properly calculated.
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
    Then I verify Tax amount For Taxable State
    Then I Add Billing Address to California
    Then I hit api to get cart response

  @Prod_B2C_CW
  Scenario: [GDC-3432] Verify that user is able to create a cart with same product code but multiple payer models
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront_0         | true              |
      | payerModel_0                 | PARTNER           |
      | paymentFrequency_0           | ONE_TIME          |
      | paymentMethod_0              | CREDIT_CARD       |
      | taxToBePaidUpfront_1         | true              |
      | payerModel_1                 | LOAN_PROVIDER     |
      | paymentFrequency_1           | ONE_TIME          |
      | paymentMethod_1              | CREDIT_CARD       |
      | taxToBePaidUpfront_2         | true              |
      | payerModel_2                 | SELF              |
      | paymentFrequency_2           | ONE_TIME          |
      | paymentMethod_2              | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | entries                      |                 3 |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable State
    Then I Add Billing Address to Pennsylvania

  @Prod_B2C_CW
  Scenario: [GDC-2870] Verify the updated billing address on the cart via a get Cart API
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii            |
    Then I hit api to get cart response
    And I verify Billing Address is not_Present
    Then I Add Billing Address to Pennsylvania
    And I verify Billing Address is Present
