Feature: B2C US Order Scenarios
  Background:
    Given I will read data in the tab "B2C_US" of the excel named "B2C_PlaceOrder_Input.xlsx"

  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_SDRental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating Standalone rental - 30 days  extension order
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental price is fixed to 75.0
    And I log Test Data for rentals
    Then Verify rental plan id is fixed to 1063
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |1     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Amex3          |



  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_SDRental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating Standalone rental - 15 days  extension order
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental price is fixed to 75.0
    And I log Test Data for rentals
    Then Verify rental plan id is fixed to 1063
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |1     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Visa2          |

  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_SDRental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating Standalone rental - Rental BuyOut
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental price is fixed to 75.0
    And I log Test Data for rentals
    Then Verify rental plan id is fixed to 1063
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |6     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Master3        |


  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_SDRental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating Standalone rental - Rental return in good and bad state
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental price is fixed to 75.0
    And I log Test Data for rentals
    Then Verify rental plan id is fixed to 1063
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I return rental in <rentalReturnCondition> state
    Then Verify rental status in return list of rental API is <rentalStatus>
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType | rentalReturnCondition |rentalStatus      |
      |3     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Master3        | GOOD                  | CANCELLED        |
      |4     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Visa2          | BAD                   | FORCEDPURCHASE   |


    #CU RENTAL
  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_CURental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating CU rental - 30 days  extension order
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 4Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    And I wait for 12 sec
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    And I wait for 12 sec
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 30 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 30
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |8     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Amex3          |



  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_CURental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating CU rental - 15 days  extension order
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And user extend rental for 15 days
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is ACTIVE
    Then Verify rental duration is increased to 15
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |8     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Visa2          |

  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_CURental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating Standalone rental - Rental BuyOut
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I Hit the API to add cart to user account and verify status code
    And User hit rental buyout api
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then Verify rental status in return list of rental API is PURCHASED
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |12     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Master3        |


  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_CURental_PlaceOrder_UsingExcelInput
  Scenario Outline: Creating CU rental - Rental return in good and bad state
    Given Create user B2CUS_CU120_EX and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User adds 12Mon_Payload product to cart
    And Add NonTaxable_Address to billing address
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I wait for 50 sec
    Then User get order details
    And I log Test Data for subscription
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    Then I verify shipping method is standard-us
    Then Verify rental status in return list of rental API is ORDERED
    And I log Test Data for rentals
    Then Verify rental status in return list of rental API is ORDERED
    Then Verify user is able to ship rental using API
    Then Verify rental status in return list of rental API is ACTIVE
    Then I get rentalEndDate
    When I return rental in <rentalReturnCondition> state
    Then Verify rental status in return list of rental API is <rentalStatus>
    And I log Test Data for rentals
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore          | deliveryMode   | creditCardType | rentalReturnCondition |rentalStatus      |
      |9      |placeOrder.yaml| cengage-b2c-us     | standard-us    | Master3        | GOOD                  | CANCELLED        |
      |10     |placeOrder.yaml| cengage-b2c-us     | standard-us    | Visa2          | BAD                   | FORCEDPURCHASE   |


    #Normal Orders
  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_NP_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - Physical Product
    Given Create user B2CUS_PHY_PROD and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I launch dummy CyberSource by passing userGuid
      | basestore | <baseStore> |
    When I enter <creditCardType> credit card number,expiry date 09-2025, CVV 1234 and complete purchase
    Then User verifies ACCEPT message
    Then User place order for B2C cart by passing UserGuid
      | basestore | <baseStore> |
      | status    |            201 |
    And I log Test Data for Normal
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |13    |placeOrder.yaml| cengage-b2c-us     | standard-us    | Amex3          |


  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_NP_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - Digital Product -Ebook
    Given Create user B2CUS_DIGITAL_PROD and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And I navigate to paypal new url for B2C stores using GUID
      |basestore	|cengage-b2c-us |
       |status	   |200            |
    Then I verify PayPal portal has launched successfully
    When I will enter paypal login details and make purchase for newer full auth implementation
    And I wait for 3 sec
    And I log Test Data for Normal
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order | yamlFileName  | baseStore          | deliveryMode   |
      |16    |placeOrder.yaml| cengage-b2c-us     | standard-us    |



  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_NP_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - Combined Product
    Given Create user B2CUS_COMBINED_PROD and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I log Test Data for Normal
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |17     |placeOrder.yaml| cengage-b2c-us     | standard-us    |  Master3       |
      |18     |placeOrder.yaml| cengage-b2c-us     | standard-us    |  Master3       |
      |19     |placeOrder.yaml| cengage-b2c-us     | standard-us    |  Visa2         |


  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_NP_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - Digital Product
    Given Create user B2CUS_DIG_PROD and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I log Test Data for Normal
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |14     |placeOrder.yaml| cengage-b2c-us     | standard-us    |  Visa2         |


  @B2C_US_PlaceOrder_UsingExcelInput  @B2C_US_NP_PlaceOrder_UsingExcelInput
  Scenario Outline: Place Order - Bundle Product
    Given Create user B2CUS_BUNDLE_PROD and login to application
    Given I open cengage commerce page
    When I Hit the API to add cart to user account and verify status code
    And User add B2C products to cart for the order number <order>
      | basestore | <baseStore>    |
      | status    |            200 |
    And User adds Taxable_Address to delivery address
    And Add Taxable_Address to billing address
    When User puts delivery mode by passing userGuid
      | basestore | <baseStore>      |
      | mode      | <deliveryMode>   |
      | status    |            200   |
    And User launches CyberSource
    And User Enters <creditCardType> card details
    Then User verifies ACCEPT message
    Then User place order and verify status code
    And I log Test Data for Normal
    Then Append the data in the "<yamlFileName>" output yaml file
    Examples:
      |order  | yamlFileName  | baseStore          | deliveryMode   | creditCardType |
      |15     |placeOrder.yaml| cengage-b2c-us     | standard-us    |  Master3       |