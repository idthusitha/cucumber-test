Feature: PAY2-4 -Ability to pay using ADYEN direct - API

#ScenariosCovered
#Scenario:2-4_TC001 CC Payment authorize request API-Positive Validation
#Scenario:2-4_TC002 CC Payment authorize request API-Negative Validation
#Scenario:2-4_TC003 CC Payment authorize positive flow-When the channel is XBE
#Scenario:2-4_TC004 CC Payment authorize positive flow-When the channel is OTA
#Scenario:2-4_TC005 CC Payment authorize Negative flow-Not approved at payment gateway-When the channel is XBE
#Scenario:2-4_TC006 CC Payment authorize Negative flow-Not approved at aeroAgent when channel is XBE
@Manual @Rollback
#Scenario:2-4_TC007 RollBack_CC Payment authorize request failed at Payment Gateway-BlockCreditRelease Success


#Points to be noted
#User should be able to configure ADYEN direct payment option as one of the payment options at aeroPay and a payment template should be created for the same.
#When Payment availability API request is sent from the booking engine to aeroPay, aeroPay triggers a segment matching API to aeroSegment and sends the response to booking engine, now we assume that, the matching payment template has ADYEN direct payment option.
#When user selects ADYEN direct payment method to do the payment from the booking engine, the authorize flow starts.
#when request is denied at payment gateway or  aeroAgent due to any valid reason, aeroPay should capture and show the appropriate error message to the requesting application
#Request from OTA should be treated in the same way as XBE(All agent validation is must)

#Workflow Description
#Positive Workflow-When the Channel is XBE or OTA
#CCAuthorizePay request is sent from consuming application to aeroPAY
#agentCreditBlock Request should be sent from aeroPAY to aeroAGENT
#agentCreditBlock Success response is sent from aeroAGENT to aeroPay
#CCAuthorizePay request is sent from aeroPAY to Payment Gateway
#CCAuthorizePay request is successful at payment gateway
#CCAuthorizePay  success response should be sent to the consuming application by aeroPAY.

  Scenario Outline:2-4_TC001 CC Payment authorize request API-Positive Validation
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Active      | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "<referenceId>",
  "paxDetails": [
    {
      "paxType": "<paxType>"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "<agencyCode>",
    "agencyName": "<agencyName>",
    "agencyCountryCode": "<agencyCountryCode>",
    "agencyIataCode": "<agencyIataCode>"
  },
  "priceDetails":
    {
      "totalPrice": "<totalPrice>",
      "paymentCurrency": "<paymentCurrency>",
      "paymentCollectedCarrier": "<paymentCollectedCarrier>"
    },
    "cardDetails": {
    "type": "<type>",
    "number": "<number>",
    "expiryMonth": "<expiryMonth>",
    "expiryYear": "<expiryYear>",
    "holderName": "<holderName>",
    "cvc": "<cvc>"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"<channel>",
      "posCountryCode":"<posCountryCode>",
      "posStateCode":"<posStateCode>",
      "posCityCode":"<posCityCode>"
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
    "referenceId": "<referenceId>",
    "paymentReferenceId":"<paymentReferenceId>",
    "paymentStatus": "APPROVED",
    "amountAuthorized": {
        "currency": "<paymentCurrency>",
        "value": "<totalPrice>"
    }
}
    """
    Examples:
      | # | referenceId | paymentReferenceId                   | paxType | agencyCode | agencyName | agencyCountryCode | agencyIataCode | totalPrice | paymentCurrency | paymentCollectedCarrier | type        | number            | expiryMonth | expiryYear | holderName  | cvc | channel | posCountryCode | posStateCode | posCityCode |
      | 1 | Ref001      | c65537a4-bf3f-4f3f-a50d-dd44353363f8 | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     |                |              |             |
      | 2 | Ref002      | c65537a4-bf3f-4f3f-a50d-dd44353363f9 | ADT     | 9020442    |            |                   |                | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | OTA     |                |              |             |
      | 3 | Ref003      | c65537a4-bf3f-4f3f-a50d-dd4435336310 | CHD     |            |            |                   |                | 200.67     | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | Web     | IN             | TN           | CHH         |
      | 4 | Ref004      | c65537a4-bf3f-4f3f-a50d-dd4435336311 | INF     |            |            |                   |                | 34.67      | INR             | G9                      | MASTER_CARD | 50000000000000001 | 09          | 2025       | Ryan Ying   | 167 | Web     | IN             |              |             |
      | 5 | Ref000      | c65537a4-bf3f-4f3f-a50d-dd44353363hu | ADT     | 9020442    |            | AE                |                | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     |                |              |             |


  Scenario Outline:2-4_TC002 CC Payment authorize request API-Negative Validation
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Active      | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "<referenceId>",
  "paxDetails": [
    {
      "paxType": "<paxType>"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "<agencyCode>",
    "agencyName": "<agencyName>",
    "agencyCountryCode": "<agencyCountryCode>",
    "agencyIataCode": "<agencyIataCode>"
  },
  "priceDetails":
    {
      "totalPrice": "<totalPrice>",
      "paymentCurrency": "<paymentCurrency>",
      "paymentCollectedCarrier": "<paymentCollectedCarrier>"
    },
    "cardDetails": {
    "type": "<type>",
    "number": "<number>",
    "expiryMonth": "<expiryMonth>",
    "expiryYear": "<expiryYear>",
    "holderName": "<holderName>",
    "cvc": "<cvc>"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"<channel>",
      "posCountryCode":"<posCountryCode>",
      "posStateCode":"<posStateCode>",
      "posCityCode":"<posCityCode>"
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "grpc-message" should be "<Response_Header_GRPCErrorDescription>"
     #There should be payment auth already done for Ref009
    Examples:
      | #  | referenceId | paxType | agencyCode | agencyName | agencyCountryCode | agencyIataCode | totalPrice | paymentCurrency | paymentCollectedCarrier | type        | number            | expiryMonth | expiryYear | holderName  | cvc | channel | posCountryCode | posStateCode | posCityCode | Response_Header_GRPCErrorDescription                                                                                                                                                                                  |
      | 1  |             | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.referenceId.missing                                                                                                                                                                               |
      | 2  | Ref006      | ADT     |            | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.agencyCode.missing                                                                                                                                                                                |
      | 3  | Ref007      | ADT     | 9020442    | ABC Tour   |                   | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.agencyCountryCode.missing                                                                                                                                                                         |
      | 4  | Ref008      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        |            | AED             | G9                      | MASTER_CARD | 50000000000000001 | 09          | 2025       | Ryan Ying   | 167 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.totalPrice.missing                                                                                                                                                                                |
      | 5  | Ref009      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        |                 | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.paymentCurrency.missing                                                                                                                                                                           |
      | 6  | Ref010      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 |         | IN             | TN           | ABC         | Mandatory.Parameter.channel.missing                                                                                                                                                                                   |
      | 7  | Ref011      |         |            |            |                   |                | 200        | AED             |                         | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.agencyCode.missing,Mandatory.Parameter.agencyCountryCode.missing,Mandatory.Parameter.PaxType.missing                                                                                              |
      | 8  | &*&H        | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.referenceId.Format.Incorrect                                                                                                                                                                            |
      | 9  | Ref012      | ADT     | ^&&gh      | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.agencyCode.Format.Incorrect                                                                                                                                                                             |
      | 10 | Ref013      | ADT     | 9020442    | ABC Tour   | UAE               | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.agencyCountryCode.Format.Incorrect                                                                                                                                                                      |
      | 11 | Ref014      | ADT     | 9020442    | ABC Tour   | AE                | 15BH&***&^^    | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.agencyIataCode.Format.Incorrect                                                                                                                                                                         |
      | 12 | Ref015      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | H&^        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.totalPrice.Format.Incorrect                                                                                                                                                                             |
      | 13 | Ref016      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | Dirhams         | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.paymentCurrency.Format.Incorrect                                                                                                                                                                        |
      | 14 | Ref017      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | Channel | IN             | TN           | ABC         | Invalid.Input.channel.Format.Incorrect                                                                                                                                                                                |
      | 15 | Ref018      |         | ^&&gh      |            | UAE               | 15BH&***&^^    | 200        | AED             |                         | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.agencyCode.Format.Incorrect ,Invalid.Input.agencyCountryCode.Format.Incorrect ,Invalid.Input.agencyIataCode.Format.Incorrect                                                                            |
      | 16 |             | Adults  | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             |                         | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | India          | Tamilnadu    | chennai     | Invalid.Input.paxType.Format.Incorrect ,Invalid.Input.posCountryCode.Format.Incorrect ,Invalid.Input.posStateCode.Format.Incorrect,Invalid.Input.posCityCode.Format.Incorrect,Mandatory.Parameter.referenceId.missing |
      | 17 | Ref004      | ADT     |            | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | referenceId already authorized                                                                                                                                                                                        |
      | 18 | Ref019      | ADT     | 9020442    |            | AE                |                | 200        | AED             | G9                      |             | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 345 | OTA     | IN             | TN           | ABC         | Mandatory.Parameter.type.missing                                                                                                                                                                                      |
      | 19 | Ref020      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        |                   | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.number.missing                                                                                                                                                                                    |
      | 20 | Ref021      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 |             | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.expiryMonth.missing                                                                                                                                                                               |
      | 21 | Ref022      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          |            | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.expiryYear.missing                                                                                                                                                                                |
      | 22 | Ref023      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       |             | 345 | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.holderName.missing                                                                                                                                                                                |
      | 23 | Ref024      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem |     | XBE     | IN             | TN           | ABC         | Mandatory.Parameter.cvc.missing                                                                                                                                                                                       |
      | 24 | Ref025      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 788788            | 12          | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.number.Format.Incorrect                                                                                                                                                                                 |
      | 25 | Ref026      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 234         | 2030       | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.expiryMonth.Format.Incorrect                                                                                                                                                                            |
      | 26 | Ref027      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 30         | Bitcoy Reem | 345 | XBE     | IN             | TN           | ABC         | Invalid.Input.expiryYear.Format.Incorrect                                                                                                                                                                             |
      | 27 | Ref028      | ADT     | 9020442    | ABC Tour   | AE                | IATA001        | 200        | AED             | G9                      | VISA        | 40000000000000001 | 12          | 2030       | Bitcoy Reem | 12  | XBE     | IN             | TN           | ABC         | Invalid.Input.cvc.Format.Incorrect                                                                                                                                                                                    |


  Scenario:2-4_TC003 CC Payment authorize positive flow-When the channel is XBE
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Active      | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
    {
  "referenceId": "Ref200",
  "paxDetails": [
    {
      "paxType": "ADT"
    },
    {
      "paxType": "CHD"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "9020442",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "AE",
    "agencyIataCode": "IATA001"
  },
  "priceDetails":
    {
      "totalPrice": "200",
      "paymentCurrency": "AED",
      "paymentCollectedCarrier": "G9"
    },
    "cardDetails": {
    "type": "VISA",
    "number": "4000000000000001",
    "expiryMonth": "12",
    "expiryYear": "2030",
    "holderName": "Bitcoy Reem",
    "cvc": "345"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"XBE",
      "posCountryCode":"",
      "posStateCode":"",
      "posCityCode":""
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    And agentCreditBlock API request is invoked with below attributes to aeroAgent
    """
  {
   "referenceId": "TC001",
   "agencyIdentification": {
     "agencyCode": "9020442",
     "agencyIATACode": ""
   },
   "marketingAirlineCode": "",
   "blockCredit": {
     "fopType": "CARD",
     "creditLimit": 200,
     "creditCurrency": "AED",
    "totalDiscount":"",
    "fopSubtype":""
   },
   "blockCreditLimitTimeInMin": "",
   "userMetaData":{
    "userId": "GSA3456",
    "userName": "William",
    "posCountry": "AE",
    "posCity": "",
    "channel": "XBE"
  },
  "creditType": "FULL_PAID"
 }
    """
    And API Response should have Below values
    """
{
  "referenceId": "TC001",
   "creditRefId": "TC001",
  "agentIataCode": "IATA001",
  "blockCreditStatus":"BLOCK_CREDIT_SUCCESS"
}
    """
    And  HTTPS status code should be "200"
#CCAuthorizePay request is sent from aeroPAY to Payment Gateway
#CCAuthorizePay request is successful at payment gateway
#CCAuthorizePay  success response should be sent to the consuming application by aeroPAY
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
    "referenceId": "Ref200",
    "paymentReferenceId":"c65537a4-bf3f-4f3f-a50d-dd44353363f5",
    "paymentStatus": "APPROVED",
    "amountAuthorized": {
        "currency": "AED",
        "value": "200"
    }
}
    """


  Scenario:2-4_TC004 CC Payment authorize positive flow-When the channel is OTA
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Active      | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
    {
  "referenceId": "Ref220",
  "paxDetails": [
    {
      "paxType": "ADT"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "9020442",
    "agencyName": "",
    "agencyCountryCode": "AE",
    "agencyIataCode": ""
  },
  "priceDetails":
    {
      "totalPrice": "200",
      "paymentCurrency": "AED",
      "paymentCollectedCarrier": "G9"
    },
    "cardDetails": {
    "type": "VISA",
    "number": "4000000000000001",
    "expiryMonth": "12",
    "expiryYear": "2030",
    "holderName": "Bitcoy Reem",
    "cvc": "345"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"OTA",
      "posCountryCode":"",
      "posStateCode":"",
      "posCityCode":""
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    And agentCreditBlock API request is invoked with below attributes to aeroAgent
    """
{
   "referenceId": "TC011",
   "agencyIdentification": {
     "agencyCode": "9020442",
     "agencyIATACode": ""
   },
   "marketingAirlineCode": "",
   "blockCredit": {
     "fopType": "CARD",
     "creditLimit": 200,
     "creditCurrency": "AED",
    "totalDiscount":"",
    "fopSubtype":""
   },
   "blockCreditLimitTimeInMin": "",
   "userMetaData":{
    "userId": "GSA3456",
    "userName": "William",
    "posCountry": "AE",
    "posCity": "",
    "channel": "XBE"
  },
  "creditType": "FULL_PAID"
 }
    """
    And API Response should have Below values
    """
{
  "referenceId": "TC011",
   "creditRefId": "TC011",
  "agentIataCode": "IATA001",
  "blockCreditStatus":"BLOCK_CREDIT_SUCCESS"
}
    """
    And  HTTPS status code should be "200"
#CCAuthorizePay request is sent from aeroPAY to Payment Gateway
#CCAuthorizePay request is successful at payment gateway
#CCAuthorizePay  success response should be sent to the consuming application by aeroPAY
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
    "referenceId": "Ref220",
    "paymentReferenceId":"c65537a4-bf3f-4f3f-a50d-dd44353363o0",
    "paymentStatus": "APPROVED",
    "amountAuthorized": {
        "currency": "AED",
        "value": "200"
    }
}
    """

  Scenario:2-4_TC005 CC Payment authorize Negative flow-Not approved at payment gateway-When the channel is XBE
    #This workflow is same when channel is XBE as well as OTA
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Active      | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
    {
  "referenceId": "Ref400",
  "paxDetails": [
    {
      "paxType": "ADT"
    },
    {
      "paxType": "INF"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "9020442",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "AE",
    "agencyIataCode": "IATA001"
  },
  "priceDetails":
    {
      "totalPrice": "200",
      "paymentCurrency": "AED",
      "paymentCollectedCarrier": "G9"
    },
    "cardDetails": {
    "type": "VISA",
    "number": "4000000000000001",
    "expiryMonth": "12",
    "expiryYear": "2030",
    "holderName": "Bitcoy Reem",
    "cvc": "345"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"XBE",
      "posCountryCode":"",
      "posStateCode":"",
      "posCityCode":""
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    And agentCreditBlock API request is invoked with below attributes to aeroAgent
    """
  {
   "referenceId": "TC002",
   "agencyIdentification": {
     "agencyCode": "9020442",
     "agencyIATACode": ""
   },
   "marketingAirlineCode": "",
   "blockCredit": {
     "fopType": "CARD",
     "creditLimit": 200,
     "creditCurrency": "AED",
    "totalDiscount":"",
    "fopSubtype":""
   },
   "blockCreditLimitTimeInMin": "",
   "userMetaData":{
    "userId": "GSA3456",
    "userName": "William",
    "posCountry": "AE",
    "posCity": "",
    "channel": "XBE"
  },
  "creditType": "FULL_PAID"
 }
    """
    And API Response should have Below values
    """
{
  "referenceId": "TC002",
   "creditRefId": "TC002",
  "agentIataCode": "IATA001",
  "blockCreditStatus":"BLOCK_CREDIT_SUCCESS"
}
    """
    And  HTTPS status code should be "200"
#CCAuthorizePay request is sent from aeroPAY to Payment Gateway
#CCAuthorizePay request is unsuccessful at payment gateway
#CCAuthorizePay  Failure response should be sent to the consuming application by aeroPAY
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "Payment Authorize failed due to issue at Payment gateway"


  Scenario:2-4_TC006 CC Payment authorize Negative flow-Not approved at aeroAgent when channel is XBE
    Given Agent's Card related information
      | AgencyId | AgentStatus | Use For | Card Status | userId  | userName |
      | 9020442  | Active      | G9      | Inactive    | GSA3456 | William  |
    When CCAuthorizePay API request is invoked with below attributes to aeroPAY
    """
    {
  "referenceId": "Ref500",
  "paxDetails": [
    {
      "paxType": "ADT"
    },
    {
      "paxType": "INF"
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": ""
  },
  "transactionAgency": {
    "agencyCode": "9020442",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "AE",
    "agencyIataCode": "IATA001"
  },
  "priceDetails":
    {
      "totalPrice": "200",
      "paymentCurrency": "AED",
      "paymentCollectedCarrier": "G9"
    },
    "cardDetails": {
    "type": "VISA",
    "number": "4000000000000001",
    "expiryMonth": "12",
    "expiryYear": "2030",
    "holderName": "Bitcoy Reem",
    "cvc": "345"
  },
    "redirectionDetails":{
        "redirectionUrl":"",
        "redirectionPlaceholder1":"",
        "redirectionPlaceholder2":"",
        "redirectionPlaceholder3":"",
        "redirectionPlaceholder4":"",
        "redirectionPlaceholder5":""
    },
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William",
      "channel":"XBE",
      "posCountryCode":"",
      "posStateCode":"",
      "posCityCode":""
    },
    "otherMetaData": [
      {
        "metaDataKey": "",
        "metaDataValue": ""
      }
    ]
  }
}
    """
    And agentCreditBlock API request is invoked with below attributes to aeroAgent
    """
  {
   "referenceId": "TC003",
   "agencyIdentification": {
     "agencyCode": "9020442",
     "agencyIATACode": ""
   },
   "marketingAirlineCode": "",
   "blockCredit": {
     "fopType": "CARD",
     "creditLimit": 200,
     "creditCurrency": "AED",
    "totalDiscount":"",
    "fopSubtype":""
   },
   "blockCreditLimitTimeInMin": "",
   "userMetaData":{
    "userId": "GSA3456",
    "userName": "William",
    "posCountry": "AE",
    "posCity": "",
    "channel": "XBE"
  },
  "creditType": "FULL_PAID"
 }
    """
#Below is the response from aeroAgent
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "Agent FOP type CARD is not active"
#CCAuthorizePay  failure response should be sent to the consuming application by aeroPAY
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "Agent FOP type CARD is not active"


  @Manual @Rollback
  Scenario:2-4_TC007 RollBack_CC Payment authorize request failed at Payment Gateway-BlockCreditRelease Success
    When Payment authorize request is received by aeroPAY from a requesting application
    Then agentCreditBlock Request should be sent from aeroPAY to aeroAGENT
    When AuthorizePay request is sent from aeroPAY to Payment Gateway
    Then AuthorizePay request is failed(due to some technical/server error)
    When agentCreditBlockRelease Request should be sent from aeroPAY to aeroAGENT via kafka
    Then AuthorizePaymentResponse with error details is sent to the consuming application (i.e) Payment authorize request failed at Payment Gateway and agentCreditBlockRelease is success at aeroAgent


