Feature: Miscellaneous Scenarios

  ##############################################  Miscellaneous Scenarios Subs  ################################################
  @Misc
  Scenario: [GDC-10113] User should not be able to place order without providing billing information
    Given Create Misc00A user
    #Given I open cengage commerce page
    #And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    Then User fetches cart details
    Then verify product in cart is Full-Access-365
    And User launches CyberSource
    Then I verify error on payment page

  @Misc
  Scenario: [GDC-10048] Verify User is not be allow to purchase the CU_FULL(4,12) with past expiry date.
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    When I enter Visa credit card number,expiry date 1-2023, CVV 111 and complete purchase
    Then User verifies ERROR message

  @Misc
  Scenario: [GDC-10090] User should not be able to place order without providing correct CartID.
    And User launches CyberSource
    And User Enters Visa card details
    Then User place order with Incorrect CartId

  #    #When I click on sidebar sign out button
  @Misc
  Scenario: [GDC-11164] Verify that user should not be able to add 24 months sub in to cart.
    Given Create Cu24NotPurchase user
    When I Hit the API to add cart to user account and verify status code
    And User adds 24Mon_Payload product to cart
    Then I verify error with given message
      | Message | Purchase Cengage Unlimited - Full-Access-730 not available for sale. |
    And I log Test Data for Cart

  ############################################## Miscellaneous Scenarios Rental ################################################
  @Misc
  Scenario: [GDC-10017] Verify that last added Rental will replace the already added sub in the cart.
    Given Create Misc00R user
    ##Given I open cengage commerce page
    ##And Add product to cart
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And User adds StandAloneRental product to cart
    Then User fetches cart details
    Then verify product in cart is 9780357662106@@180I

#Need Update
  @Misc
  Scenario: [GDC-10093] Verify that  User should not be able to place order without providing Shipping information details
    And User adds empty to delivery address
    And I get Error details 

  @Misc
  Scenario: [GDC-10088] Verify that  User should not be able to place order without providing Payment details
    And User adds Taxable_Address to delivery address
    And Add NonTaxable_Address to billing address
    Then I get delivery modes
    Then I put standard-us as shipping mode
    And User launches CyberSource
    Then User place order without payment details
    
    @Misc
    Scenario: [GDC-10369] Verify that user is able to search product details [PDP] using API.
    Given I Hit Api to create B2CUS Token
    And I hit PDP search
      | basestore | cengage-b2c-us    |
      | product     | 9781337696456@@NA |
      | status    |               200 |
    Then I verify results in response
      | isbn13            | 9781337696456 |
      | price.currencyIso | USD |

  @Misc
  Scenario: [GDC-10094] Verify that  User should not be able to place order by providing incorrect cart id.
    And User launches CyberSource
    And User Enters Visa2 card details
    Then User verifies ACCEPT message
    Then User place order with Incorrect CartId

  ##############################################        New              ############################################
  @Misc
  Scenario: [GDC-10157] Verify no input validation on name field of customer API
    #regexp: ^[\w'\-,.][^0-9_!¡?÷?¿\/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$
    Given I Hit Api to create B2CUS Token
    And I register a user using API
      | basestore | cengage-b2c-us |
      | fName     | read           |
      | lName     | read           |
      | email     | automation     |
      | store     | B2CUS          |
      | status    |            201 |
    Then I verify B2CUS customer is registered

  @Misc
  Scenario: [GDC-10131] Verify no input validation on name email of customer registration API
    #regexp: \b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\b
    Given I Hit Api to create B2CUS Token
    And I register a user using API
      | basestore | cengage-b2c-us     |
      | fName     | FirstName          |
      | lName     | LastName           |
      | email     | 123@yopyy123.wwwrr |
      | store     | B2CUS              |
      | status    |                201 |
    Then I verify B2CUS customer is registered

  @Misc
  Scenario: [GDC-10010] Verify that Cengage Products API returns purchaseOptions and rental duration to be 180
    Given I Hit Api to create B2CUS Token
    And I hit product details API
      | basestore         | cengage-b2c-us |
      | query             |  9781111831646 |
      | priceReferenceIds |                |
      | fields            | DEFAULT        |
      | status            |            200 |
    Then I verify results in response
      | rentalOptions[0].duration | 180 |
      | rentalOptions[1].duration |  -1 |

  @Misc
  Scenario: [GDC-10424] Verify that facet Copyright Year is appearing in Search API response.
    Given I Hit Api to create B2CUS Token
    And I hit search
      | basestore | cengage-b2c-us |
      | query     | maths          |
      | status    |            200 |
    Then I verify Copyright Year facet in api response

  @Misc
  Scenario: [GDC-10481] [B2C] Verify that Reason code '201' appears in the SOP response API and Place Order API when the user has added an invalid credit card number while adding payment details using the CyberSource URL. 
    Given Create SopScenario user
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters Invalid card details
    Then User verifies ERROR message
    And I Hit SOP Response API
      | baseSiteId | cengage-b2c-us |
      | cartId     | Valid          |
      | status     |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    Then User place order for B2C cart
      | basestore | cengage-b2c-us |
      | status    |            400 |
    Then I verify following details in API response
      | errors[0].message | CC Payment is failing due to Reason Code |
      | errors[0].reason  |                                      102 |
    And Test Data for GDC-10481 and Cart details
    
     @Misc
  Scenario: [GDC-12853] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2CUS Token
    Given I hit API to create B2CUS user
    Then I verify following details in API response
      | entityName   | UNIV OF MICHIGAN ANN ARBOR |
      | entityNumber |                       6811 |
    And I hit API to update b2c customer Entitydetails_PATCH
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  @Misc
  Scenario: [GDC-12855] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2CUS Token
    Given I hit API to create B2CUS user
    Then I verify following details in API response
      | entityName   | UNIV OF MICHIGAN ANN ARBOR |
      | entityNumber |                       6811 |
    And I hit API to update b2c customer Entitydetails_PUT
      | basestore | cengage-b2c-us |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
      
      
   #-----------------------------------Removed code----------------------------
        #@Misc_Smoke
  #Scenario: [GDC-12834] [B2C US] Verify that API should returns '400' status code in SOP response API's  response with error message if skipping the CyberSource details.
    #Given Create SopScenario_2 user
   #When I Hit the API to add cart to user account and verify status code
    #And User adds HardCover product to cart
    #And User adds Taxable_Address to delivery address
    #And Add Taxable_Address to billing address
    #Then I get delivery modes
    #Then I put standard-us as shipping mode
    #And I Hit SOP Response API
      #| baseSiteId | cengage-b2c-us |
      #| cartId     | Valid          |
      #| status     |            400 |
    #Then I verify following details in API response
      #| errors[0].message | PaymentInfo [CC Payment info is empty] is invalid for the current cart |
    #And Test Data for GDC-12825 and Cart details
      
    
