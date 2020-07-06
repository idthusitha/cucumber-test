Feature: PAY2-35 -Confirm payment of ADYEN using capture flow - Travel agent flow

#ScenariosCovered
#Scenario:2-35_TC001 CC Payment confirm_request API-Positive Validation
#Scenario:2-35_TC002 CC Payment confirm_request API-Negative Validation-Missing & Invalid Values
#Scenario:2-35_TC003 CC Payment confirm_positive flow-When the channel is XBE or OTA
#Scenario:2-35_TC004 CC Payment confirm_Negative flow-Not approved at payment gateway-When the channel is XBE
#Scenario:2-35_TC005 CC Payment confirm_Resend the same confirm request which is already confirmed

  Scenario Outline:2-35_TC001 CC Payment confirm_request API-Positive Validation
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel |
      | ReF30       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | Authorization_Success | XBE     |
      | ReF31       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     |
      | ReF32       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | Authorization_Success | XBE     |
    When CConfirmPay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "<referenceId>",
  "paymentReferenceId": "<paymentReferenceId>",
  "ticketDocuments": [
    {
      "documentType": "<documentType>",
      "documentNumber": "<documentNumber>",
      "couponNumber": "<couponNumber>",
      "relatedDocumentNumber": "<relatedDocumentNumber>",
      "relatedCouponNumber": "<relatedCouponNumber>",
      "paxRecord": {
        "pnr": "",
        "passengerName": "<passengerName>"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]
    }
  ],
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William"
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
    Then status code should be "200"
    And API Response should have Below values
    """
{
    "referenceId": "<referenceId>",
    "paymentReferenceId":"<paymentReferenceId>",
    "paymentConfirmation": "CONFIRMED"
}
    """
    Examples:
      | # | referenceId | paymentReferenceId                   | documentType | documentNumber | couponNumber | relatedDocumentNumber | relatedCouponNumber | passengerName |
      | 1 | ReF30       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         | 4552100000002  |              |                       |                     | Jacob         |
      | 2 | ReF31       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000003  | 1            | 3552100000003         | 3                   | Mary          |
      | 3 | ReF32       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | EMDS         | 4552100000004  | 1            |                       |                     | Jain          |


  Scenario Outline:2-35_TC002 CC Payment confirm_request API-Negative Validation-Missing & Invalid Values
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel |
      | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | Authorization_Success | XBE     |
      | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     |
      | ReF35       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | Authorization_Success | XBE     |
    When CConfirmPay API request is invoked with below attributes to aeroPAY
      """
{
  "referenceId": "<referenceId>",
  "paymentReferenceId": "<paymentReferenceId>",
  "ticketDocuments": [
    {
      "documentType": "<documentType>",
      "documentNumber": "<documentNumber>",
      "couponNumber": "<couponNumber>",
      "relatedDocumentNumber": "<relatedDocumentNumber>",
      "relatedCouponNumber": "<relatedCouponNumber>",
      "paxRecord": {
        "pnr": "",
        "passengerName": "<passengerName>"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]
    }
  ],
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William"
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
    Examples:
      | #  | referenceId | paymentReferenceId                   | documentType | documentNumber | couponNumber | relatedDocumentNumber | relatedCouponNumber | passengerName | Response_Header_GRPCErrorDescription                                                   |
      | 1  | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         |                |              |                       |                     | Jacob         | Mandatory.Parameter.documentNumber.missing                                             |
      | 2  | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         | 4552100000006  |              |                       |                     |               | Mandatory.Parameter.passengerName.missing                                              |
      | 3  | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTTTY       |                |              |                       |                     | Jacob         | Invalid.Input.documentType.Format.Incorrect,Mandatory.Parameter.documentNumber.missing |
      | 4  | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         | 4A             |              |                       |                     |               | Invalid.Input.documentNumber.Format.Incorrect                                          |
      | 5  | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         | 4552100000006  |              |                       |                     | JH7&&&(&(*    | Invalid.Input.passengerName.Format.Incorrect                                           |
      | 6  | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         |                | 1            | 3552100000005         | 3                   | Marry         | Mandatory.Parameter.documentNumber.missing                                             |
      | 7  | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  |              | 3552100000005         | 3                   | Marry         | Mandatory.Parameter.couponValue.missing                                                |
      | 8  | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  | 1            |                       | 3                   | Marry         | Mandatory.Parameter.relatedDocumentNumber.missing                                      |
      | 9  | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  | 1            | 3552100000005         |                     | Marry         | Mandatory.Parameter.relatedCouponValue.missing                                         |
      | 10 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  | 1            | 3552100000005         | 3                   |               | Mandatory.Parameter.passengerName.missing                                              |
      | 11 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 |              | 4552100000007  | 1            | 3552100000005         | 3                   | Marry         | Mandatory.Parameter.documentType.missing                                               |
      | 12 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 872478         | 1            | 3552100000005         | 3                   | Marry         | Invalid.Input.documentNumber                                                           |
      | 13 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  | 64$          | 3552100000005         | 3                   | Marry         | Invalid.Input.CouponNumber.Format.Incorrect                                            |
      | 14 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | EMDA         | 4552100000007  | 1            | HGFH678               | 3                   | Marry         | Invalid.Input.relatedDocumentNumber.Format.Incorrect                                   |
      | 15 | ReF35       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | EMDS         |                | 1            |                       |                     | Jain          | Mandatory.Parameter.documentNumber.missing                                             |
      | 16 | ReF35       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | EMDS         | 4552100000008  |              |                       |                     | Jain          | Mandatory.Parameter.CouponNumber.missing                                               |


  Scenario:2-35_TC003 CC Payment confirm_positive flow-When the channel is XBE or OTA
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel | aeroAgentReferenceId |
      | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     | TC005                |
    When CConfirmPay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "ReF34",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f2",
  "ticketDocuments": [
    {
      "documentType": "TKTT",
      "documentNumber": "8442100000000",
      "couponNumber": "",
      "relatedDocumentNumber": "3754364326432",
      "relatedCouponNumber": "3",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Kiby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]
    },
    {

      "documentType": "TKTT",
      "documentNumber": "8442100000001",
      "couponNumber": "",
      "relatedDocumentNumber": "",
      "relatedCouponNumber": "",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Aby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]

    }
  ],
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William"
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
#aeroPay sends the Capture request to the payment gateway
#Success response is received from the payment gateway
#aeroPay send the ConfirmCredit request to aeroAgent through Kafka
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
    "referenceId": "ReF34",
    "paymentReferenceId":"c65537a4-bf3f-4f3f-a50d-dd44353363f2",
    "paymentConfirmation": "CONFIRMED"
}
    """


  Scenario:2-35_TC004 CC Payment confirm_Negative flow-Not approved at payment gateway-When the channel is XBE
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel | aeroAgentReferenceId |
      | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     | TC005                |
    When CConfirmPay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "ReF374",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f2",
  "ticketDocuments": [
    {
      "documentType": "TKTT",
      "documentNumber": "8442100000000",
      "couponNumber": "",
      "relatedDocumentNumber": "3754364326432",
      "relatedCouponNumber": "3",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Kiby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]
    },
    {

      "documentType": "TKTT",
      "documentNumber": "8442100000001",
      "couponNumber": "",
      "relatedDocumentNumber": "",
      "relatedCouponNumber": "",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Aby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]

    }
  ],
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William"
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
#aeroPay sends the Capture request to the payment gateway
#Failure response is received from the payment gateway
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "400"
    Then No API Response
    And  Read errorMessageDesc from payment gateway and print in responseHeaders['grpc-message']
  #The error response from payment gateway should be shown to the consuming application


  Scenario:2-35_TC005 CC Payment confirm_Resend the same confirm request which is already confirmed
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                     | Channel | aeroAgentReferenceId |
      | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Order_Confirmation_Success | XBE     | TC005                |
    When CConfirmPay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "ReF398974",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f2",
  "ticketDocuments": [
    {
      "documentType": "TKTT",
      "documentNumber": "8442100000000",
      "couponNumber": "",
      "relatedDocumentNumber": "3754364326432",
      "relatedCouponNumber": "3",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Kiby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]
    },
    {

      "documentType": "TKTT",
      "documentNumber": "8442100000001",
      "couponNumber": "",
      "relatedDocumentNumber": "",
      "relatedCouponNumber": "",
      "paxRecord": {
        "pnr": "6789458",
        "passengerName": "Aby Nancy"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "500",
          "currencyCode": "EGP"
        },
        {
          "type": "TAX",
          "value": "250",
          "currencyCode": "EGP"
        },
        {
          "type": "SURCHARGE",
          "value": "250",
          "currencyCode": "EGP"
        }
      ]

    }
  ],
  "paymentMetaData": {
    "userMetaData": {
      "userId": "GSA3456",
      "userName": "William"
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
#CCCancel API is idempotent based on reference ID and payment reference ID
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
    "referenceId": "ReF34",
    "paymentReferenceId":"c65537a4-bf3f-4f3f-a50d-dd44353363f2",
    "paymentConfirmation": "CONFIRMED"
}
    """