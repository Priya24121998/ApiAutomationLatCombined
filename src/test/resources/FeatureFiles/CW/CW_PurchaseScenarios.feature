Feature: CW Purchse Scenarios

  @Pruchaset_Reg
  Scenario: [GDC-2916] Verify that User is able to create a cart and place order when payerModel is SELF.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

  @Pruchaset_Reg
  Scenario: [GDC-2927] Verify that User is able to create a cart and place order when payerModel is PARTNER.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | PARTNER      |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

  @Pruchase_Smoke
  Scenario: [GDC-2934] Verify that User is able to create a cart and place order when payer model is LOANPROVIDER.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |           100 |
      | taxToBePaidUpfront           | true          |
      | payerModel                   | LOAN_PROVIDER |
      | paymentFrequency             | ONE_TIME      |
      | paymentMethod                | CREDIT_CARD   |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

  @Pruchaset_Reg
  Scenario: [GDC-3483] Verify that user should not be able to place an order without providing CC info if
    StudentUpfront portion is greater than zero for payer model Self

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details

  @Pruchaset_Reg
  Scenario: [GDC-3515] Verify that user should not be able to place an order without providing CC info if
    StudentUpfront portion is greater than zero for payer model Partner

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | PARTNER      |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details

  @Pruchase_Smoke
  Scenario: [GDC-3516] Verify that user should not be able to place an order without providing CC info if
    StudentUpfront portion is greater than zero for payer model LOAN_PROVIDER

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |           100 |
      | taxToBePaidUpfront           | true          |
      | payerModel                   | LOAN_PROVIDER |
      | paymentFrequency             | ONE_TIME      |
      | paymentMethod                | CREDIT_CARD   |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details

  @Pruchaset_Reg
  Scenario: [GDC-3433] Verify that user is able to place order without entering credit card info for
    ONE_TIME, PARTNER only ZERO downpayment scenario when taxToBePaidUpfront: false.

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |            0 |
      | taxToBePaidUpfront           | false        |
      | payerModel                   | PARTNER      |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                |              |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order and verify status code

  @Pruchaset_Reg
  Scenario: [GDC-3435] Verify that user should not be able to place order without entering credit card info for
    payerModel: SELF and paymentFrequency: RECURRING, ZERO downpayment scenario.

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |            0 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | RECURRING    |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details

  @Pruchaset_Reg 
  Scenario: [GDC-3469] Verify that user should not be able to place order without entering credit card info for
    paymentFrequency: RECURRING, and payerModel: PARTNER when taxToBePaidUpfront: true.

    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |            0 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | PARTNER      |
      | paymentFrequency             | RECURRING    |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details
       
  @Pruchaset_Reg 
  Scenario: [GDC-3467] Verify that user should be able to place order after entering credit card info for RECURRING, ZERO downpayment scenario.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |            0 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | RECURRING    |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    
  @Pruchase_Smoke
  Scenario: [GDC-3477] Verify that user is able to place order for PARTNER and LOAN_PROVIDER payer model.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |          100  |
      | taxToBePaidUpfront_0         | true          |
      | payerModel_0                 | PARTNER       |
      | paymentFrequency_0           | ONE_TIME      |
      | paymentMethod_0              | CREDIT_CARD   |
      | taxToBePaidUpfront_1         | true          |
      | payerModel_1                 | LOAN_PROVIDER |
      | paymentFrequency_1           | ONE_TIME      |
      | paymentMethod_1              | CREDIT_CARD   | 
      | productCode                  | CONTAINER_PRODUCT |  
      | entries                      | 2             |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code

    @Pruchaset_Reg
  	Scenario: [GDC-3470] Verify that user should not be able to place order without entering credit card info for "paymentFrequency": "ONE-TIME", and "payerModel": "LOAN_PROVIDER" if StudentUpfront portion is  zero.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion | 0             |
      | taxToBePaidUpfront           | true          |
      | payerModel                   | LOAN_PROVIDER |
      | paymentFrequency             | ONE_TIME      |
      | paymentMethod                | CREDIT_CARD   |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania  |
    Then I Add Billing Address to Pennsylvania
    Then Place CW order Without payment details
    
    
    @Pruchaset_Reg 
  Scenario: [GDC-3475] Verify that user is able to place order for 'SELF' and 'PARTNER' payer model.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |          100  |
      | taxToBePaidUpfront_0         | true          |
      | payerModel_0                 | SELF 	       |
      | paymentFrequency_0           | ONE_TIME      |
      | paymentMethod_0              | CREDIT_CARD   |
      | taxToBePaidUpfront_1         | true          |
      | payerModel_1                 | PARTNER			 |
      | paymentFrequency_1           | ONE_TIME      |
      | paymentMethod_1              | CREDIT_CARD   | 
      | productCode                  | CONTAINER_PRODUCT |  
      | entries                      | 2             |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    
    @Pruchaset_Reg 
  Scenario: [GDC-3476] Verify that user is able to place order for 'SELF' and 'LOAN_PROVIDER' payer model.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |          100  |
      | taxToBePaidUpfront_0         | true          |
      | payerModel_0                 | SELF 	       |
      | paymentFrequency_0           | ONE_TIME      |
      | paymentMethod_0              | CREDIT_CARD   |
      | taxToBePaidUpfront_1         | true          |
      | payerModel_1                 | LOAN_PROVIDER |
      | paymentFrequency_1           | ONE_TIME      |
      | paymentMethod_1              | CREDIT_CARD   | 
      | productCode                  | CONTAINER_PRODUCT |  
      | entries                      | 2             |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code  
      
    @Pruchaset_Reg
  Scenario: [GDC-3478] Verify that user should be able to place order with Payer model: Self & paymentFrequency: ONE-TIME, Payer model: Self & paymentFrequency: RECURRING
    Given I hit API to create WFS token
    When I hit API to create WFS Cart for multiple entries
      | orderType                    | NEW           |
      | studentUpfrontPaymentPortion |          100  |
      | taxToBePaidUpfront_0         | true          |
      | payerModel_0                 | SELF          |
      | paymentFrequency_0           | ONE_TIME      |
      | paymentMethod_0              | CREDIT_CARD   |
      | taxToBePaidUpfront_1         | true          |
      | payerModel_1                 | SELF          |
      | paymentFrequency_1           | RECURRING     |
      | paymentMethod_1              | CREDIT_CARD   |
      | productCode                  | CONTAINER_PRODUCT |   
      | entries                      | 2             |
      | addressType                  | Pennsylvania  |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code
    
  #@Pruchaset_Reg
  #Scenario: [GDC-3518] Verify that user should be able to create orders using CSR key in payload
    #Given I hit API to create WFS token
    #When I hit API to create WFS Cart using CSR key in payload
      #| orderType                    | NEW          |
      #| studentUpfrontPaymentPortion |          100 |
      #| taxToBePaidUpfront           | true         |
      #| payerModel                   | SELF         |
      #| paymentFrequency             | ONE_TIME     |
      #| paymentMethod                | CREDIT_CARD  |
      #| productCode                  | CONTAINER_PRODUCT |
      #| addressType                  | Pennsylvania |
    #Then I verify Tax amount For Taxable state
    #Then I Add Billing Address to Pennsylvania
    #And launch CW CyberSource
    #And User Enters Visa card details
    #Then User verifies ACCEPT message
    #Then Place CW order and verify status code
    
 #=====================================================Regression========================================   
   
   @Pruchaset_Reg @exone
  Scenario: [GDC-3550] Verify that User is getting proper Error message if Invalid Order id is passed.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW          |
      | studentUpfrontPaymentPortion |          100 |
      | taxToBePaidUpfront           | true         |
      | payerModel                   | SELF         |
      | paymentFrequency             | ONE_TIME     |
      | paymentMethod                | CREDIT_CARD  |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Pennsylvania |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Pennsylvania
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code    
    Then I verify error in order response With Invalid orderId 
    
    
     @Pruchaset_Reg
    Scenario: [GDC-3557] Verify that user should not be able to cancel with no consignments entries in an order.
    Given I hit API to create WFS token
    When I hit API to create WFS Cart
      | orderType                    | NEW         |
      | studentUpfrontPaymentPortion |         100 |
      | taxToBePaidUpfront           | true        |
      | payerModel                   | SELF        |
      | paymentFrequency             | ONE_TIME    |
      | paymentMethod                | CREDIT_CARD |
      | productCode                  | CONTAINER_PRODUCT |
      | addressType                  | Hawaii      |
    Then I verify Tax amount For Taxable state
    Then I Add Billing Address to Hawaii
    And launch CW CyberSource
    And User Enters Visa card details
    Then User verifies ACCEPT message
    Then Place CW order and verify status code 
    Then I verify error in response Without consignment 
