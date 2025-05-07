Feature: CW Cart Scenarios

  #---------------------------------------Smoke-----------------------------------------------------------------------------------------
  @CWCart_Smoke
  Scenario: [GDC-3432] Verify that user is able to create a cart with same product code but multiple payer models .
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
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then I hit api to validate cart response

  @CWCart_Smoke
  Scenario: [GDC-2932] Verify that user is able to retrieve the cart for LOAN PROVIDER through API.
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
    Then I hit api to validate cart response
    Then I hit api to get cart response
    Then I verify cart details with Properties
      | code                                      | value                             |
      | orderType                                 | NEW                               |
      | entries[0].quantity                       |                                 1 |
      | entries[0].shippingUpcharge               |                               0.0 |
      | entries[0].product.code                   | CONTAINER_PRODUCT                 |
      | student.uid                               | automationtestuser@mailinator.com |
      | deliveryAddress                           | value                             |
      | totalPriceWithTax.value                   |                             636.0 |
      | totalDiscounts.value                      |                               0.0 |
      | subTotal.value                            |                             600.0 |
      | studentUpfrontPaymentPortionWithTax.value |                             136.0 |
      | studentUpfrontPaymentPortion.value        |                             100.0 |
      | entries                                   | value_1                           |
      | containerHeader                           | value                             |
      | entries[0].registrationKey                | value                             |
      | entries[0].provisionActionRequest         | P                                 |
      | totalTax.value                            |                              36.0 |
      | entries[0].containerItem                  | value                             |
      | entries[0].taxablePortion.value           |                             600.0 |
      | entries[0].digital                        | true                              |
      | entries[0].taxToBePaidUpfront             | true                              |
      | entries[0].payerModel                     | LOAN_PROVIDER                     |
      | entries[0].paymentFrequency               | ONE_TIME                          |
      | paymentType.displayName                   | Card Payment                      |

  @CWCart_Smoke
  Scenario: [GDC-2873] Verify that user get all the entries under the cart entries if multiple products are added in the same cart
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
      | entries                      |                 2 |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I hit api to get cart response
    Then I verify 2 entries in cart response

  @CWCart_Smoke
  Scenario: [GDC-2874] Verify that if user add a products twice in the cart it will reflect in CartEntries with unique registration IDs.
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
      | addressType                  | Pennsylvania      |
    Then I hit api to get cart response
    Then I verify 2 entries in cart response
    Then I verify 2 unique Registration Keys in cart response

  #=============================================================Regression============================================================
  @CWCart_Reg
  Scenario: [GDC-3466] Verfiy that user is able to create WFS cart without failure line 1 should not be more than 40 chars.
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
    Then I Add Billing Address to Pennsylvania

  #Scenario: [GDC-3425] Verify that error message should returned when each address line1 can be of maximum size 40.
  #Given I hit API to create WFS token
  #When I hit API to create WFS Cart
  #| orderType                    | NEW               |
  #| studentUpfrontPaymentPortion |               100 |
  #| taxToBePaidUpfront           | true              |
  #| payerModel                   | LOAN_PROVIDER     |
  #| paymentFrequency             | ONE_TIME          |
  #| paymentMethod                | CREDIT_CARD       |
  #| productCode                  | CONTAINER_PRODUCT |
  #| addressType                  | Pennsylvania      |
  #Then I Add Billing Address to Invalid
  #Then I verify Error message for maximum Character
  @CWCart_Reg
  Scenario: [GDC-3434] [Partially Automated] Verify that Cart Details reflects in Backoffice after creating a cart with course registration(s) and product as CONTAINER_PRODUCT with multiple payer models.
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
    Then I Add Billing Address to Pennsylvania
    Then I hit api to validate cart response

  @CWCart_Reg
  Scenario: [GDC-2930] Verify that user is able to retrieve cart data through API when payerModel is SELF.
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
    Then I hit api to validate cart response
    Then I hit api to get cart response
    Then I verify cart details with Properties
      | code                                      | value                             |
      | orderType                                 | NEW                               |
      | entries[0].quantity                       |                                 1 |
      | entries[0].shippingUpcharge               |                               0.0 |
      | entries[0].product.code                   | CONTAINER_PRODUCT                 |
      | student.uid                               | automationtestuser@mailinator.com |
      | deliveryAddress                           | value                             |
      | totalPriceWithTax.value                   |                             636.0 |
      | totalDiscounts.value                      |                               0.0 |
      | subTotal.value                            |                             600.0 |
      | studentUpfrontPaymentPortionWithTax.value |                             136.0 |
      | studentUpfrontPaymentPortion.value        |                             100.0 |
      | entries                                   | value_1                           |
      | containerHeader                           | value                             |
      | entries[0].registrationKey                | value                             |
      | entries[0].provisionActionRequest         | P                                 |
      | totalTax.value                            |                              36.0 |
      | entries[0].containerItem                  | value                             |
      | entries[0].taxablePortion.value           |                             600.0 |
      | entries[0].digital                        | true                              |
      | entries[0].taxToBePaidUpfront             | true                              |
      | entries[0].payerModel                     | SELF                              |
      | entries[0].paymentFrequency               | ONE_TIME                          |
      | paymentType.displayName                   | Card Payment                      |

  @CWCart_Reg
  Scenario: [GDC-2931] Verify that user is able to retrieve the cart for PARTNER through API.
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
    Then I hit api to validate cart response
    Then I hit api to get cart response
    Then I verify cart details with Properties
      | code                                      | value                             |
      | orderType                                 | NEW                               |
      | entries[0].quantity                       |                                 1 |
      | entries[0].shippingUpcharge               |                               0.0 |
      | entries[0].product.code                   | CONTAINER_PRODUCT                 |
      | student.uid                               | automationtestuser@mailinator.com |
      | deliveryAddress                           | value                             |
      | totalPriceWithTax.value                   |                             636.0 |
      | totalDiscounts.value                      |                               0.0 |
      | subTotal.value                            |                             600.0 |
      | studentUpfrontPaymentPortionWithTax.value |                             136.0 |
      | studentUpfrontPaymentPortion.value        |                             100.0 |
      | entries                                   | value_1                           |
      | containerHeader                           | value                             |
      | entries[0].registrationKey                | value                             |
      | entries[0].provisionActionRequest         | P                                 |
      | totalTax.value                            |                              36.0 |
      | entries[0].containerItem                  | value                             |
      | entries[0].taxablePortion.value           |                             600.0 |
      | entries[0].digital                        | true                              |
      | entries[0].taxToBePaidUpfront             | true                              |
      | entries[0].payerModel                     | PARTNER                           |
      | entries[0].paymentFrequency               | ONE_TIME                          |
      | paymentType.displayName                   | Card Payment                      |

  @CWCart_Reg
  Scenario: [GDC-3447]: User is getting error message if creating the cart with same registration key twice.
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
    When I hit API to create WFS Cart with same registration key
      | orderType                    | NEW               |
      | studentUpfrontPaymentPortion |               100 |
      | taxToBePaidUpfront           | true              |
      | payerModel                   | LOAN_PROVIDER     |
      | paymentFrequency             | ONE_TIME          |
      | paymentMethod                | CREDIT_CARD       |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania      |
    Then I verify Error message for duplicate registration key

  @CWCart_Reg
  Scenario: [GDC-2933] Verify that user is getting error message while retrieving cart with invalid cartId
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
    Then I verify error in cart response With Invalid cartId

  @CWCart_Reg
  Scenario: [GDC-2940] Verify that Error message appears when user tries to create a cart with invalid base store.
    Given I hit API to create WFS token
    When I create WFS Cart with Invalid Basestore
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | addressType                  | Pennsylvania |
    Then I verify error while creating cart
      | error | invalidBaseSiteId |

  @CWCart_Reg
  Scenario: [GDC-2941] Verify that Error message appears when user tries to create a cart with invalid product code.
    Given I hit API to create WFS token
    When I create WFS Cart with Invalid Product Code
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |           100 |
      | taxToBePaidUpfront           | true          |
      | payerModel                   | SELF          |
      | paymentFrequency             | ONE_TIME      |
      | paymentMethod                | CREDIT_CARD   |
      | productCode                  | CONTAINER_PRO |
      | addressType                  | Pennsylvania  |
    Then I verify product not found error

  @CWCart_Reg
  Scenario: [GDC-3292] Verify if user add same products in cart, entries should be created with same Commerce Product ID.
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
      | addressType                  | Pennsylvania      |
    Then I hit api to get cart response
    Then I verify 2 entries in cart response
    Then I verify 2 same productCode in cart response

  @CWCart_Reg
  Scenario: [GDC-3484] Verify that error message should returned when OrderType is null or any invalid value rather than NEW or TRANSFER while creating wfs cart
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | Invalid            |
      | studentUpfrontPaymentPortion |                650 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                400 |
    Then I verify error in cart response With Invalid order type

  @CWCart_Reg
  Scenario: [GDC-3205] Verify that student payment amount portion determined on Cart should never exceeding the Cart Total on Commerce"
    Given I hit API to create WFS token
    When I hit API to create new CW Cart
      | baseSiteId                   | cengage-b2c-wfs-us |
      | orderType                    | NEW                |
      | studentUpfrontPaymentPortion |                650 |
      | taxToBePaidUpfront           | true               |
      | payerModel                   | SELF               |
      | paymentFrequency             | ONE_TIME           |
      | paymentMethod                | CREDIT_CARD        |
      | productCode                  | CONTAINER_PRODUCT  |
      | addressType                  | Pennsylvania       |
      | status                       |                400 |
    Then I verify error while creating cart
      | error | studentUpfrontPaymentPortion |
  #Scenario: [GDC-10157] Verify no input validation on name field of customer API
    #Given I hit API to create WFS token
    #When I hit API to create WFS Cart with user info
      #| fName                        | read              |
      #| lName                        | read              |
      #| email                        | automation        |
      #| orderType                    | NEW               |
      #| studentUpfrontPaymentPortion |               100 |
      #| taxToBePaidUpfront           | true              |
      #| payerModel                   | LOAN_PROVIDER     |
      #| paymentFrequency             | ONE_TIME          |
      #| paymentMethod                | CREDIT_CARD       |
      #| productCode                  | CONTAINER_PRODUCT |
      #| addressType                  | Pennsylvania      |
    #Then I verify CW user is registered and cart is created
#
  #Scenario: [GDC-10131] Verify no input validation on name email of customer registration API
    #Given I hit API to create WFS token
    #When I hit API to create WFS Cart with user info
      #| fName                        | FirstName              |
      #| lName                        | LastName               |
      #| email                        | test123@yopyy123.wwwrr |
      #| orderType                    | NEW                    |
      #| studentUpfrontPaymentPortion |                    100 |
      #| taxToBePaidUpfront           | true                   |
      #| payerModel                   | LOAN_PROVIDER          |
      #| paymentFrequency             | ONE_TIME               |
      #| paymentMethod                | CREDIT_CARD            |
      #| productCode                  | CONTAINER_PRODUCT      |
      #| addressType                  | Pennsylvania           |
    #Then I verify CW user is registered and cart is created

