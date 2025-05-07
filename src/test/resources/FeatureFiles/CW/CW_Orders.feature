Feature: CW Order Scenarios

################################################## Smoke ###############################################################

@CWCart_Smoke
  Scenario: [GDC-10385] [Partially Automated] Verify Placed order details under outbound in BackOffice for non-US address
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | PortRico          |
   # Then I verify Tax amount For Taxable state
    Then I Add Billing Address to PortRico
    And launch CW CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

 ############################################### Regression #################################################

#Updating Very late
  @CW_Orders_Reg
  Scenario: [GDC-2842] Verify that order STATUS is in Pending state after creating an order.
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    And I wait for 50 sec
    Then I check for PENDING order status in response

  @CW_Orders_Reg
  Scenario: [GDC-2843] Verify that order status is Completed if all the items status of the order is Completed.
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    And I wait for 20 sec
		Then I create consignment
		And I wait for 65 sec
    Then I check for COMPLETED order status in response

  @CW_Orders_Reg
  Scenario: [GDC-2844] Verify that order status is In_Process if any of the items status of the order is not Completed.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront_0         | true              |
      | payerModel_0                 | SELF           |
      | paymentFrequency_0           | ONE_TIME          |
      | paymentMethod_0              | CREDIT_CARD       |
      | taxToBePaidUpfront_1         | true              |
      | payerModel_1                 | SELF     |
      | paymentFrequency_1           | ONE_TIME          |
      | paymentMethod_1              | CREDIT_CARD       |
      | entries                      |                 2 |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    And I wait for 50 sec
		Then I create consignment
		And I wait for 50 sec
    Then I check for IN_PROCESS order status in response

  @CW_Orders_Reg
  Scenario: [GDC-2883] Verify that user is able to fetch all the data for the order placed through API.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               600 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | SELF              |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    And I wait for 50 sec
    Then I hit api to validate order response

  @CW_Orders_Reg
  Scenario: [GDC-2907] Verify that system should mark the consignment entry status to "Cancelled" after cancellation order is created successfully for SELF payermodel.
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
    Then I verify consignment entry status to CANCELLED

  @CW_Orders_Reg
  Scenario: [GDC-2948] Verify that error message appears when user tries to place an order with invalid CartID.
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
    When I try to place order with invalid CartID
    Then I check for error in response

  @CW_Orders_Reg
  Scenario: [GDC-2949] Verify that error message appears when user tries to place an order with invalid Base store
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
    When I place CW order with invalid BaseStrore
    Then I verify error for Invalid Basestore

  @CW_Orders_Reg
  Scenario: [GDC-3534] Verify that system should mark the consignment entry status to "Cancelled" after cancellation order is created successfully for PARTNER payermodel.
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
    Then I verify consignment entry status to CANCELLED

  @CW_Orders_Reg
  Scenario: [GDC-3535] Verify that system should mark the consignment entry status to "Cancelled" after cancellation order is created successfully for LOAN_PROVIDER payermodel.
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I create consignment
    And I cancel registration before Transfer
    Then I verify consignment entry status to CANCELLED

  @CW_Orders_Reg
  Scenario: [GDC-3548] Verify that error message should be returned while pass invalid OrderId through API.
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I verify error in order response With Invalid orderId

  @CW_Orders_Reg
  Scenario: [GDC-3546] Verify that user is able to get order history detail while passing orderId through API
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I get order details
    Then I verify Order details with Properties
      | code                                      | value                          |
      | orderType                                 | NEW                            |
      | entries[0].quantity                       |                              1 |
      | entries[0].shippingUpcharge               |                            0.0 |
      | entries[0].product.code                   | CONTAINER_PRODUCT              |
      | student.uid                               | automationtestuser@mailinator.com |
      | deliveryAddress                           | value                          |
      | totalPriceWithTax.value                   |                         628.27 |
      | totalDiscounts.value                      |                            0.0 |
      | subTotal.value                            |                          600.0 |
      | studentUpfrontPaymentPortionWithTax.value |                         628.27 |
      | studentUpfrontPaymentPortion.value        |                          600.0 |
      | entries                                   | value_1                        |
      | containerHeader                           | value                          |
      | entries[0].registrationKey                | value                          |
      | entries[0].provisionActionRequest         | P                              |
      | totalTax.value                            |                          28.27 |
      | entries[0].containerItem                  | value                          |
      | entries[0].taxablePortion.value           |                          600.0 |
      | entries[0].digital                        | true                           |
      | entries[0].taxToBePaidUpfront             | true                           |
      | entries[0].payerModel                     | SELF                           |
      | entries[0].paymentFrequency               | ONE_TIME                       |
      | paymentMode                               | Credit Card                    |

  @CW_Orders_Reg
  Scenario: [GDC-3549] Verify that user is able to fetch all the data for the order placed with Multiple Products.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront_0         | true              |
      | payerModel_0                 | SELF              |
      | paymentFrequency_0           | ONE_TIME          |
      | paymentMethod_0              | CREDIT_CARD       |
      | taxToBePaidUpfront_1         | true              |
      | payerModel_1                 | SELF              |
      | paymentFrequency_1           | ONE_TIME          |
      | paymentMethod_1              | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | entries                      |                 2 |
      | addressType                  | Hawaii            |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    Then I get order details
    Then I verify Order details with Properties
      | code                                      | value                          |
      | orderType                                 | NEW                            |
      | entries[0].quantity                       |                              1 |
      | entries[0].shippingUpcharge               |                            0.0 |
      | entries[0].product.code                   | CONTAINER_PRODUCT              |
      | student.uid                               | automationtestuser@mailinator.com |
      | deliveryAddress                           | value                          |
      | totalPriceWithTax.value                   |                        1256.54 |
      | totalDiscounts.value                      |                            0.0 |
      | subTotal.value                            |                         1200.0 |
      | studentUpfrontPaymentPortionWithTax.value |                         156.54 |
      | studentUpfrontPaymentPortion.value        |                          100.0 |
      | entries                                   | value_2                        |
      | containerHeader                           | value                          |
      | entries[1].registrationKey                | value                          |
      | entries[0].provisionActionRequest         | P                              |
      | totalTax.value                            |                          56.54 |
      | entries[0].containerItem                  | value                          |
      | entries[0].taxablePortion.value           |                          600.0 |
      | entries[0].digital                        | true                           |
      | entries[0].taxToBePaidUpfront             | true                           |
      | entries[0].payerModel                     | SELF                           |
      | entries[0].paymentFrequency               | ONE_TIME                       |
      | paymentMode                               | Credit Card                    |
      
      
   
