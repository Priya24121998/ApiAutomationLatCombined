Feature: B2B CA Misc API Scenarios

  #################################################  Smoke   ################################################################
    @B2BCA_Misc
  Scenario: [GDC-12955] User is able to update customer Entitydetails using PATCH API
    Given I Hit Api to create B2BCA Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-ca |
      | store     | CA             |
      | email     | automation     |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PATCH
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
  

  @B2BCA_Misc
  Scenario: [GDC-12953] User is able to update customer Entitydetails using PUT API
    Given I Hit Api to create B2BCA Token
    And I hit b2b User creation API
      | basestore | cengage-b2b-ca |
      | store     | CA             |
      | email     | automation     |
      | status    |            201 |
    And I hit API to update b2b customer Entitydetails_PUT
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |
    Then I get customer details
      | basestore | cengage-b2b-ca |
      | status    |            200 |
    Then I verify following details in API response
      | entityName   | ARBOR |
      | entityNumber |   254 |

  #################################################  Reggression   ###########################################################
  #@B2BCA_Misc
  #Scenario: [GDC-450] Verify that Shipping charges are calculated after shipping method is set via Cart OCC API
    #Given I Hit Api to create B2BCA Token
    #When I hit API to create B2BCA cart
      #| basestore | cengage-b2b-ca |
      #| status    |            201 |
    #And User add B2B products to cart
      #| basestore | cengage-b2b-ca |
      #| Product   | b2busproduct2  |
      #| status    |            200 |
    #And User set bill to ship to account number
      #| basestore           | cengage-b2b-ca |
      #| shipToAccountNumber |       84002336 |
      #| billToAccountNumber |       84002335 |
      #| status              |            202 |
    #When I hit get cart details API
      #| basestore | cengage-b2b-ca |
      #| status    |            200 |
    #Then I verify following details in API response
      #| totalItems              |       1 |
      #| totalPriceWithTax.value |   119.54 |
      #| orderType               | REGULAR |
    #Then I hit API to Set  delivery modes
      #| basestore | cengage-b2b-ca   |
      #| code      | 35175049_PPA_GRD |
      #| status    |              200 |
    #Then I hit API to Set drop ship address
      #| basestore | cengage-b2b-ca     |
      #| address   | CA_dropShipAddress |
      #| status    |                201 |
    #When I hit get cart details API
      #| basestore | cengage-b2b-ca |
      #| status    |            200 |
    #Then I verify following details in API response
      #| totalItems              |       1 |
      #| totalPriceWithTax.value |   157.59 |
      #| deliveryCost.value      |   38.08 |
      #| totalTax.value          |    2.79 |
      #| orderType               | REGULAR |
    #And Test Data for GDC-450 and Cart details
