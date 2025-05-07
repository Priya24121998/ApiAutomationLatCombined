Feature: CW Get Scenarios

  @CW_Reg
  Scenario: [GDC-2848] Verify that user is able to get all base store through api
    Given I hit API to create WFS token
    When I hit API to Get All BaseStores
    Then I verify all BaseStores in response
      | B2C US     | cengage-b2c-us     |
      | B2C EMEA   | cengage-b2c-emea   |
      | B2B Canada | cengage-b2b-ca     |
      | B2C US WFS | cengage-b2c-wfs-us |
      | B2B US     | cengage-b2b-us     |
      | B2C CA     | cengage-b2c-ca     |
      | B2C AU     | cengage-b2c-au     |
      | B2C NZ     | cengage-b2c-nz     |

  @CW_Reg
  Scenario: [GDC-2870] Verify that user is able to update billing address data on an existing Cart through API"
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
    #And I verify Billing Address is not_Present
    Then I Add Billing Address to Pennsylvania
    And I verify Billing Address is Present

  #@CW_Reg
  #Scenario: [GDC-2876] Verify that user is able to update the shipping address for an existing cart
  #Given I hit API to create WFS token
  #When I hit API to create WFS Cart
  #| orderType                    | NEW               |
  #| studentUpfrontPaymentPortion |               100 |
  #| taxToBePaidUpfront           | true              |
  #| payerModel                   | SELF              |
  #| paymentFrequency             | ONE_TIME          |
  #| paymentMethod                | CREDIT_CARD       |
  #| productCode                  | CONTAINER_PRODUCT |
  #| addressType                  | Hawaii            |
  #Then I Add Billing Address to Hawaii
  #And I Update delivary Address to Pennsylvania
  #Then I hit api to get cart response
  #And I verify delivary Address is set to Pennsylvania
  @CW_Reg
  Scenario: [GDC-3215] Verify that error message should be returned while pass invalid registrationId through API
    Given I hit API to create WFS token
    When I hit Order history API
      | StudentUid      | automationtestuser@yopmail.com |
      | registrationKey | Invalid                        |
      | Status          |                            400 |
    Then I verify error With Invalid registrationKey

  @CW_Reg
  Scenario: [GDC-3216] Verify that error message should be returned while pass invalid StudentID in order history API
    Given I hit API to create WFS token
    When I hit Order history API
      | StudentUid      | automationtestuser@yopmail.com1 |
      | registrationKey |                                 |
      | Status          |                             400 |
    Then I verify error With Invalid StudentUID

  @CW_Reg
  Scenario: [GDC-3220] Verify that user is able get all the orders details through StudentGUID
    Given I hit API to create WFS token
    When I hit Order history API
      | StudentUid      | automationtestuser@yopmail.com |
      | registrationKey |                                |
      | Status          |                            200 |
    Then verify that response have all order details

  @CW_Reg
  Scenario: [GDC-3218] Verify user is able to get order history details with providing valid registrationId in order history API
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
    When I hit Order history API
      | StudentUid      | automationtestuser@mailinator.com |
      | registrationKey | valid                             |
      | Status          |                               200 |
    Then I verify Order history API response details with Properties
      | orders[0].code                                      | value                             |
      | orders[0].orderType                                 | NEW                               |
      | orders[0].entries[0].quantity                       |                                 1 |
      | orders[0].entries[0].shippingUpcharge               |                               0.0 |
      | orders[0].entries[0].product.code                   | CONTAINER_PRODUCT                 |
      | orders[0].student.uid                               | automationtestuser@mailinator.com |
      | orders[0].deliveryAddress                           | value                             |
      | orders[0].totalPriceWithTax.value                   |                            628.27 |
      | orders[0].totalDiscounts.value                      |                               0.0 |
      | orders[0].subTotal.value                            |                             600.0 |
      | orders[0].studentUpfrontPaymentPortionWithTax.value |                            628.27 |
      | orders[0].studentUpfrontPaymentPortion.value        |                             600.0 |
      | orders[0].entries                                   | value_1                           |
      | orders[0].containerHeader                           | value                             |
      | orders[0].entries[0].registrationKey                | value                             |
      | orders[0].entries[0].provisionActionRequest         | P                                 |
      | orders[0].totalTax.value                            |                             28.27 |
      | orders[0].entries[0].containerItem                  | value                             |
      | orders[0].entries[0].taxablePortion.value           |                             600.0 |
      | orders[0].entries[0].digital                        | true                              |
      | orders[0].entries[0].taxToBePaidUpfront             | true                              |
      | orders[0].entries[0].payerModel                     | SELF                              |
      | orders[0].entries[0].paymentFrequency               | ONE_TIME                          |
      | orders[0].paymentMode                               | Credit Card                       |

#Obsolute Requirement
  #Scenario: [GDC-3302] Verify that error message should returned when empty line1 AND line2 > 40 in billing/delivery address.
    #Given I hit API to create WFS token
    #When I hit API to create WFS Cart
      #| orderType                    | NEW               |
      #| studentUpfrontPaymentPortion |               100 |
      #| taxToBePaidUpfront           | true              |
      #| payerModel                   | SELF              |
      #| paymentFrequency             | ONE_TIME          |
      #| paymentMethod                | CREDIT_CARD       |
      #| productCode                  | CONTAINER_PRODUCT |
      #| addressType                  | Hawaii            |
    #Then I Add Billing Address to EmptyLine1
    #Then I verify Address error for EmptyLine1
    #And I Update delivary Address to EmptyLine1
    #Then I verify Address error for EmptyLine1

#Duplicate
#Scenario: [GDC-3589] Verify that Api Throws Proper Error message when entered unsupported delivery Country.
#Given I hit API to create WFS token
#When I hit API to create WFS Cart
#| orderType                    | NEW               |
#| studentUpfrontPaymentPortion |               100 |
#| taxToBePaidUpfront           | true              |
#| payerModel                   | SELF              |
#| paymentFrequency             | ONE_TIME          |
#| paymentMethod                | CREDIT_CARD       |
#| productCode                  | CONTAINER_PRODUCT |
#| addressType                  | Hawaii            |
#Then I Add Billing Address to Hawaii
#And I Update delivary Address to InvalidIsd
#Then verify invalid delivery address error is thrown

