Feature: PAY2-2 -ADYEN refund flow - Travel agent flow

#ScenariosCovered
#Scenario:2-2_TC001 CC Payment refund_request API-Positive Validation
#Scenario:2-2_TC002 CC Payment refund_request API-Negative Validation-Missing Values
#Scenario:2-2_TC003 CC Payment refund_request API-Negative Validation-Invalid Values
#Scenario:2-2_TC004 CC Payment refund_positive flow-When the channel is XBE or OTA
#Scenario:2-2_TC005 CC Payment refund_Negative flow-Not approved at payment gateway-When the channel is XBE
#Scenario:2-2_TC006 CC Payment refund_Resend the same refund request
#Scenario:2-2_TC007 CC Payment refund_Resend the same refund request which was already partially refunded

#Notes-For Reference
#Refund credit from aeroPay to aeroAgent is Kafka
#Total price may have a non refundable component such as tax which should never be refunded
#paymentReferenceId  which is previously partially refunded can be refunded again for the remaining amount
#Below is the basic refund logic
#|#|Authorized Amount|Non Refundable tax amount|Is Full Refund|Refund Amount|Refund Status|Error                                         |
#|1|2000             | 300                     |F             |1700         |SUCCESS      |                                              |
#|2|2000             | 300                     |T             |1700         |FAIL         |INVALID REFUND AMOUNT                         |
#|3|2000             | 300                     |T             |2000         |FAIL         |INVALID REFUND AMOUNT                         |
#|4|2000             | 300                     |F             |2000         |FAIL         |INVALID REFUND AMOUNT                         |
#|5|2000             | 300                     |F             |1500         |SUCCESS      |                                              |
#|6|1000             | 0                       |T             |1000         |SUCCESS      |                                              |
#|7|1000             | 0                       |F             |1000         |FAIL         |INVALID REFUND AMOUNT                         |
#|8|1000             | 0                       |T             |500          |FAIL         |INVALID REFUND AMOUNT                         |
#|9|1000             | 0                       |F             |200          |SUCCESS      |                                              |
#|1|1000             | 0                       |T             |2000         |FAIL         |REFUNDED AMOUNT IS MORE THAN AUTHORIZED AMOUNT|

Scenario Outline:2-2_TC001 CC Payment refund_request API-Positive Validation
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status        | TotalPriceAuthorized | Currency | Non-RefundableTaxAmount | documentType | documentNumber |
      | 12ed1284-eac3-3104-8524-d917571007KP | TC100       | Order_Confirmation_Success | 2000                 | AED      | 300                     | TKTT         | 8441500000478  |
      | 12ed1284-eac3-3104-8524-d917571007KQ | TC101       | Order_Confirmation_Success | 1000                 | AED      | 0                       | EMDA         | 8441500000479  |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "<referenceId>",
"paymentReferenceId": "<paymentReferenceId>",
"ticketDocuments": [
{
"documentType": "<documentType>",
"documentNumber": "<documentNumber>",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "<pnr>",
"paxName": "<passengerName>"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "500",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "250",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "250",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "250",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "<refundValue>",
"refundCurrency": "<refundCurrency>",
"paymentCollectedCarrier": "<paymentCollectedCarrier>",
"isFullRefund": "<isFullRefund>"
},
"paymentMetaData": {
"userMetaData": {
"userId": "<userId>",
"userName": "<userName>",
"languagePreferred": "",
"channel": "<channel>",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
  "paymentReferenceId": "<paymentReferenceId>",
  "refundStatus": "REFUNDED"
}
    """
    Examples:
      | # | referenceId | paymentReferenceId                   | documentType | documentNumber | pnr     | paxName    | refundValue | refundCurrency | paymentCollectedCarrier | isFullRefund | userId  | userName | channel |
      | 1 | TC003       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | false        | GSA3456 | William  | XBE     |
      | 2 | TC004       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  |         | James Rana | 1500        | AED            | G9                      | false        | GSA3456 | William  | XBE     |
      | 3 | TC005       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | false        |         | William  | XBE     |
      | 4 | TC006       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | false        | GSA3456 |          | XBE     |
      | 5 | TC007       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  |         | James Rana | 1700        | AED            | G9                      | false        | GSA3456 |          |         |
      | 6 | TC008       | 12ed1284-eac3-3104-8524-d917571007KQ | EMDA         | 8441500000479  |         | Mathew     | 1000        | AED            | G9                      | true         | GSA3456 |          |         |
      | 7 | TC009       | 12ed1284-eac3-3104-8524-d917571007KQ | EMDA         | 8441500000479  |         | Mathew     | 800         | AED            | G9                      | false        | GSA3456 | William  | XBE     |


  Scenario Outline:Scenario:2-2_TC002 CC Payment refund_request API-Negative Validation-Missing Values
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status        | TotalPriceAuthorized | Currency | Non-RefundableTaxAmount | documentType | documentNumber |
      | 12ed1284-eac3-3104-8524-d917571007KP | TC100       | Order_Confirmation_Success | 2000                 | AED      | 300                     | TKTT         | 8441500000478  |
      | 12ed1284-eac3-3104-8524-d917571007KQ | TC101       | Order_Confirmation_Success | 1000                 | AED      | 0                       | EMDA         | 8441500000479  |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "<referenceId>",
"paymentReferenceId": "<paymentReferenceId>",
"ticketDocuments": [
{
"documentType": "<documentType>",
"documentNumber": "<documentNumber>",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "<pnr>",
"paxName": "<passengerName>"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "500",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "250",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "250",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "250",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "<refundValue>",
"refundCurrency": "<refundCurrency>",
"paymentCollectedCarrier": "<paymentCollectedCarrier>",
"isFullRefund": "<isFullRefund>"
},
"paymentMetaData": {
"userMetaData": {
"userId": "<userId>",
"userName": "<userName>",
"languagePreferred": "",
"channel": "<channel>",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
      | # | referenceId | paymentReferenceId                   | documentType | documentNumber | pnr     | paxName    | refundValue | refundCurrency | paymentCollectedCarrier | isFullRefund | userId  | userName | channel | Response_Header_GRPCErrorDescription                |
      | 1 | TC010       |                                      | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | false        | GSA3456 | William  | XBE     | Mandatory.Parameter.paymentReferenceId.missing      |
      | 2 | TC011       | 12ed1284-eac3-3104-8524-d917571007KP |              | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | false        | GSA3456 | William  |         | Mandatory.Parameter.documentType.missing            |
      | 3 | TC012       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         |                | 7895643 | James Rana | 1700        | AED            | G9                      | false        | GSA3456 | William  | XBE     | Mandatory.Parameter.documentNumber.missing          |
      | 4 | TC013       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 |            | 1700        | AED            | G9                      | false        | GSA3456 | William  | OTA     | Mandatory.Parameter.passengerName.missing           |
      | 5 | TC014       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana |             | AED            | G9                      | false        | GSA3456 | William  | XBE     | Mandatory.Parameter.refundValue.missing             |
      | 6 | TC015       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      |              | GSA3456 | William  | XBE     | Mandatory.Parameter.refundType.missing              |
      | 7 | TC016       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        |                | G9                      | false        |         |          | XBE     | Mandatory.Parameter.refundCurrency.missing          |
      | 8 | TC017       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        |                |                         | false        | GSA3456 | William  | OTA     | Mandatory.Parameter.paymentCollectedCarrier.missing |
      | 9 |             | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        |                |                         | false        | GSA3456 | William  | XBE     | Mandatory.Parameter.referenceId.missing             |


  Scenario Outline:Scenario:2-2_TC003 CC Payment refund_request API-Negative Validation-Invalid Values
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status        | TotalPriceAuthorized | Currency | Non-RefundableTaxAmount | documentType | documentNumber |
      | 12ed1284-eac3-3104-8524-d917571007KP | TC100       | Order_Confirmation_Success | 2000                 | AED      | 300                     | TKTT         | 8441500000478  |
      | 12ed1284-eac3-3104-8524-d917571007KQ | TC101       | Order_Confirmation_Success | 1000                 | AED      | 0                       | EMDA         | 8441500000479  |
      | 12ed1284-eac3-3104-8524-d917571007KR | TC200       | Pay_Auth_Success           | 1000                 | AED      | 0                       |              |                |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "<referenceId>",
"paymentReferenceId": "<paymentReferenceId>",
"ticketDocuments": [
{
"documentType": "<documentType>",
"documentNumber": "<documentNumber>",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "<pnr>",
"paxName": "<passengerName>"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "500",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "250",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "250",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "250",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "<refundValue>",
"refundCurrency": "<refundCurrency>",
"paymentCollectedCarrier": "<paymentCollectedCarrier>",
"isFullRefund": "<isFullRefund>"
},
"paymentMetaData": {
"userMetaData": {
"userId": "<userId>",
"userName": "<userName>",
"languagePreferred": "",
"channel": "<channel>",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
    Then HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "grpc-message" should be "<Response_Header_GRPCErrorDescription>"
    Examples:
      | # | referenceId | paymentReferenceId                   | documentType | documentNumber | pnr     | paxName    | refundValue | refundCurrency | paymentCollectedCarrier | isFullRefund | userId  | userName | channel | Response_Header_GRPCErrorDescription                                                              |
      | 1 | TC020       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 1700        | AED            | G9                      | true         | GSA3456 | William  | XBE     | Invalid.Input.Incorrect isFullRefundT                                                             |
      | 2 | TC021       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 2000        | AED            | G9                      | true         | GSA3456 | William  | XBE     | Invalid.Input.Incorrect refundValue                                                               |
      | 3 | TC022       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500000478  | 7895643 | James Rana | 2000        | AED            | G9                      | false        | GSA3456 | William  | XBE     | Invalid.Input.Incorrect refundValue                                                               |
      | 4 | TC023       | 12ed1284-eac3-3104-8524-d917571007KQ | EMDA         | 8441500000479  |         | Mathew     | 1000        | AED            | G9                      | false        | GSA3456 | William  | XBE     | Invalid.Input.Incorrect refundValue                                                               |
      | 5 | TC024       | 12ed1284-eac3-3104-8524-d917571007KQ | EMDA         | 8441500000479  |         | Mathew     | 500         | AED            | G9                      | true         | GSA3456 | William  | XBE     | Invalid.Input.Incorrect refundValue                                                               |
      | 6 | TC025       | 12ed1284-eac3-3104-8524-d917571007KQ | EMDA         | 8441500000479  |         | Mathew     | 2000        | AED            | G9                      | true         | GSA3456 | William  | XBE     | Invalid.Input.Refund value is greater than confirmed amount                                       |
      | 7 | TC026       | 12ed1284-eac3-3104-8524-d917571007KR | EMDA         | 8441500000479  |         | Calci      | 2000        | AED            | G9                      | true         | GSA3456 | William  | OTA     | Invalid.Input.paymentReferenceId not  confirmed                                                   |
      | 8 | TC027       | 12ed1284-eac3-3104-8524-d917571007KP | TKTT         | 8441500012345  | 7895643 | James Rana | 1700        | AED            | G9                      | true         | GSA3456 | William  | XBE     | Invalid.Input.Incorrect isFullRefund,Invalid.Input.documentNumber not matching paymentReferenceId |


  Scenario:2-2_TC004 CC Payment refund_positive flow-When the channel is XBE or OTA
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status        | TotalPriceAuthorized | Currency | Non-RefundableTaxAmount | documentType | documentNumber              | paxName            |
      | 12ed1284-eac3-3104-8524-d917571007KL | TC300       | Order_Confirmation_Success | 1000                 | AED      | 0                       | TKTT         | 8441500000479,8441500000480 | Rosa Gij,Adam Yang |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "TC030",
"paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
"ticketDocuments": [
{
"documentType": "TKTT",
"documentNumber": "8441500000479",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "7865436",
"paxName": "Rosa Gij"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
},
{
"documentType": "TKTT",
"documentNumber": "8441500000480",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "78542367",
"paxName": "Adam Yang"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "1000",
"refundCurrency": "AED",
"paymentCollectedCarrier": "G9",
"isFullRefund": "true"
},
"paymentMetaData": {
"userMetaData": {
"userId": "GSA3456",
"userName": "William",
"languagePreferred": "",
"channel": "XBE",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
#aeroPay sends the refund request to the payment gateway
#Success response is received from the payment gateway
#aeroPay send the RefundCredit request to aeroAgent through Kafka
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
  "refundStatus": "REFUNDED"
}
    """

  Scenario:2-2_TC005 CC Payment refund_Negative flow-Not approved at payment gateway-When the channel is XBE or OTA
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status        | TotalPriceAuthorized | Currency | Non-RefundableTaxAmount | documentType | documentNumber              | paxName            |
      | 12ed1284-eac3-3104-8524-d917571007KL | TC300       | Order_Confirmation_Success | 1000                 | AED      | 0                       | TKTT         | 8441500000479,8441500000480 | Rosa Gij,Adam Yang |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "TC031",
"paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
"ticketDocuments": [
{
"documentType": "TKTT",
"documentNumber": "8441500000479",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "7865436",
"paxName": "Rosa Gij"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
},
{
"documentType": "TKTT",
"documentNumber": "8441500000480",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "78542367",
"paxName": "Adam Yang"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "1000",
"refundCurrency": "AED",
"paymentCollectedCarrier": "G9",
"isFullRefund": "true"
},
"paymentMetaData": {
"userMetaData": {
"userId": "GSA3456",
"userName": "William",
"languagePreferred": "",
"channel": "XBE",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
#aeroPay sends the refund request to the payment gateway
#Failure response is received from the payment gateway
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "400"
    Then No API Response
    And  Read errorMessageDesc from payment gateway and print in responseHeaders['grpc-message']
  #The error response from payment gateway should be shown to the consuming application


  Scenario:2-2_TC006 CC Payment refund_Resend the same refund request again for which full refund is already successful
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status | TotalPriceAuthorized | Currency | RefundedAmount | documentType | documentNumber              | paxName            |
      | 12ed1284-eac3-3104-8524-d917571007KL | TC300       | Refund_Success      | 1000                 | AED      | 1000           | TKTT         | 8441500000479,8441500000480 | Rosa Gij,Adam Yang |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "TC300",
"paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
"ticketDocuments": [
{
"documentType": "TKTT",
"documentNumber": "8441500000479",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "7865436",
"paxName": "Rosa Gij"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
},
{
"documentType": "TKTT",
"documentNumber": "8441500000480",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "78542367",
"paxName": "Adam Yang"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "1000",
"refundCurrency": "AED",
"paymentCollectedCarrier": "G9",
"isFullRefund": "true"
},
"paymentMetaData": {
"userMetaData": {
"userId": "GSA3456",
"userName": "William",
"languagePreferred": "",
"channel": "XBE",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
#Refund API is idempotent based on reference ID and payment reference ID
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
  "refundStatus": "REFUNDED"
}
    """

  Scenario:2-2_TC007 CC Payment refund_Resend the same refund request which was already partially refunded
    Given Information of the Payment Reference ID for which CreditRefund request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status | TotalPriceAuthorized | Currency | RefundedAmount | documentType | documentNumber              | paxName            |
      | 12ed1284-eac3-3104-8524-d917571007KL | TC300       | Refund_Success      | 1000                 | AED      | 500            | TKTT         | 8441500000479,8441500000480 | Rosa Gij,Adam Yang |
    When CCRefund API request is invoked with below attributes to aeroPAY
    """
{
"referenceId": "TC400",
"paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
"ticketDocuments": [
{
"documentType": "TKTT",
"documentNumber": "8441500000479",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "7865436",
"paxName": "Rosa Gij"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
},
{
"documentType": "TKTT",
"documentNumber": "8441500000480",
"couponNumber": "",
"relatedDocumentNumber": "",
"relatedCouponNumber": "",
"paxRecord": {
"pnr": "78542367",
"paxName": "Adam Yang"
},
"conjunctionTicketNumber": "",
"fareAndChargeDetails": [
{
"type": "FARE",
"value": "300",
"currencyCode": "AED"
},
{
"type": "TAX",
"value": "100",
"currencyCode": "AED"
},
{
"type": "SURCHARGE",
"value": "100",
"currencyCode": "AED"
}
],
"relatedTicketDocumentCouponId": "",
"taxFeeRecords": [
{
"netReporting": false,
"amount": "100",
"type": "Airport Tax"
}
]
}
],
"refundDetails": {
"refundValue": "500",
"refundCurrency": "AED",
"paymentCollectedCarrier": "G9",
"isFullRefund": "false"
},
"paymentMetaData": {
"userMetaData": {
"userId": "GSA3456",
"userName": "William",
"languagePreferred": "",
"channel": "XBE",
"posCountryCode": "",
"posCityCode": "",
"posStateCode": ""
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
#aeroPay sends the refund request to the payment gateway
#Success response is received from the payment gateway
#aeroPay send the RefundCredit request to aeroAgent through Kafka
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "200"
    And  API Response should have Below values
    """
{
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007KL",
  "refundStatus": "REFUNDED"
}
    """