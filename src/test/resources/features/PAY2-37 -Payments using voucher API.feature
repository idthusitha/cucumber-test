Feature: PAY2-37 -Payments using voucher API

#ScenariosCovered
#Scenario:2-37_TC001 Voucher Payment authorize request API-Positive Validation
#Scenario:2-37_TC002 Voucher Payment authorize request API-Negative Validation
#Scenario:2-37_TC003 Voucher Payment-Partial voucher payment
#Scenario:2-37_TC004 Voucher Payment Confirmation request API-Positive Validation
#Scenario:2-37_TC005 Voucher Payment Confirmation request API-Negative Validation
#Scenario:2-37_TC006 Voucher Payment E2E-Positive Flow
#Scenario:2-37_TC007 Voucher Payment E2E-Negative Flow-Error at aeroCustomer


  Scenario:2-37_TC001 Voucher Payment authorize request API-Positive Validation
#    Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987     | 2000   | Hellan            | Bot              | AED      |
    When VoucherAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "Ref10000",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987",
      "voucherRequestedAmount": 1500.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRequest is sent to aeroCustomer
#RedeemVoucherResponse is received from aeroCustomer
    Then HTTPS status code should be "200"
    And  VoucherAuthorizePay API Response should have Below values
    """
{
  "referenceId": "Ref10001",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f8",
  "passengerVoucherPaymentResponse": [
    {
      "passengerVoucherRPH": "1",
      "voucherPaymentStatus":  "VOUCHER_PAYMENT_APPROVED",
      "voucherAmountApproved": 1500.00,
      "voucherRemainingAmount": 500.00,
      "voucherPaymentCurrencyCode": "AED"
    }
  ]
}
    """


  Scenario:2-37_TC002 Voucher Payment authorize request API-Negative Validation
    When VoucherAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987",
      "voucherRequestedAmount": 1500.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "grpc-message" should be " Mandatory.Parameter.referenceId.missing"


  Scenario:2-37_TC003 Voucher Payment-Partial voucher payment
#    Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987     | 2000   | Hellan            | Bot              | AED      |
    When VoucherAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "Ref10002",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987",
      "voucherRequestedAmount": 2500.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRequest is sent to aeroCustomer
#RedeemVoucherResponse is received from aeroCustomer
    Then HTTPS status code should be "200"
    And  VoucherAuthorizePay API Response should have Below values
    """
{
  "referenceId": "Ref10000",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f8",
  "passengerVoucherPaymentResponse": [
    {
      "passengerVoucherRPH": "1",
      "voucherPaymentStatus":  "VOUCHER_PAYMENT_PARTIAL_APPROVED",
      "voucherAmountApproved": 2000.00,
      "voucherRemainingAmount": 0.00,
      "voucherPaymentCurrencyCode": "AED"
    }
  ]
}
    """

  Scenario Outline:2-37_TC004 Voucher Payment Confirmation request API-Positive Validation
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel |
      | ReF30       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | Authorization_Success | XBE     |
      | ReF31       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     |
      | ReF32       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | Authorization_Success | XBE     |
    When Voucher Order Confirmation API request is invoked with below attributes to aeroPAY
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


  Scenario Outline:2-37_TC005 Voucher Payment Confirmation request API-Negative Validation
    Given Below details should be present for payment confirmation:
      | referenceId | paymentReferenceId                   | Status                | Channel |
      | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | Authorization_Success | XBE     |
      | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 | Authorization_Success | XBE     |
      | ReF35       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 | Unknown_Status        | XBE     |
    When Voucher Order Confirmation API request is invoked with below attributes to aeroPAY
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
      | # | referenceId | paymentReferenceId                   | documentType | documentNumber | couponNumber | relatedDocumentNumber | relatedCouponNumber | passengerName | Response_Header_GRPCErrorDescription       |
      | 1 | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         |                |              |                       |                     | Jacob         | Mandatory.Parameter.documentNumber.missing |
      | 2 | ReF33       | c65537a4-bf3f-4f3f-a50d-dd44353363f1 | TKTT         | 4552100000006  |              |                       |                     |               | Mandatory.Parameter.passengerName.missing  |
      | 3 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f2 |              | 4552100000007  | 1            | 3552100000005         | 3                   | Marry         | Mandatory.Parameter.documentType.missing   |
      | 4 | ReF34       | c65537a4-bf3f-4f3f-a50d-dd44353363f3 |              |                |              |                       |                     |               | Invalid paymentReferenceId Status          |
      | 5 |             | c65537a4-bf3f-4f3f-a50d-dd44353363f2 |              | 4552100000007  | 1            | 3552100000005         | 3                   | Marry         | Mandatory.Parameter.referenceId.missing    |

  Scenario:2-37_TC006 Voucher Payment E2E-Positive Flow
#    Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987     | 2000   | Hellan            | Bot              | AED      |
    When VoucherAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "Ref10005",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987",
      "voucherRequestedAmount": 1500.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRequest is sent to aeroCustomer
#RedeemVoucherResponse is received from aeroCustomer
    Then HTTPS status code should be "200"
    And  VoucherAuthorizePay API Response should have Below values
    """
{
  "referenceId": "Ref10005",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f8",
  "passengerVoucherPaymentResponse": [
    {
      "passengerVoucherRPH": "1",
      "voucherPaymentStatus":  "VOUCHER_PAYMENT_APPROVED",
      "voucherAmountApproved": 1500.00,
      "voucherRemainingAmount": 500.00,
      "voucherPaymentCurrencyCode": "AED"
    }
  ]
}
    """
    When Voucher Order Confirmation API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "Ref10005",
  "paymentReferenceId": "c65537a4-bf3f-4f3f-a50d-dd44353363f8",
  "ticketDocuments": [
    {
      "documentType": "TKTT",
      "documentNumber": "4552100000002",
      "couponNumber": "",
      "relatedDocumentNumber": "",
      "relatedCouponNumber": "",
      "paxRecord": {
        "pnr": "",
        "passengerName": "Tingu Ton"
      },
      "conjunctionTicketNumber": "",
      "fareAndChargeDetails": [
        {
          "type": "FARE",
          "value": "1000",
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
    And Voucher Order Confirmation API Response should have Below values
    """
{
    "referenceId": "Ref10005",
    "paymentReferenceId":"c65537a4-bf3f-4f3f-a50d-dd44353363f8",
    "paymentConfirmation": "CONFIRMED"
}
    """


  Scenario:2-37_TC007 Voucher Payment E2E-Negative Flow-Error at aeroCustomer
#    Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987     | 2000   | Hellan            | Bot              | AED      |
    When VoucherAuthorizePay API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "Ref10005",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987",
      "voucherRequestedAmount": 1500.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRequest is sent to aeroCustomer
#RedeemVoucherRequest failed at aeroCustomer due to technical error
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "RedeemVoucherRequest failed at aeroCustomer"