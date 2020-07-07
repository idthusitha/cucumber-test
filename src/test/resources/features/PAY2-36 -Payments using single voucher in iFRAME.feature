Feature: PAY2-36 -Payments using single voucher in iFRAME
#This feature concentrates only iFrame Voucher workflow

#ScenariosCovered
#Scenario:TC001 Voucher iFrame-E2E Positive Flow
#Scenario:TC002 Voucher iFrame-E2E Negative Flow-ViewVoucherRq-Incorrect Pax detail
#Scenario:TC003 Voucher iFrame-E2E Negative Flow-Authorize Failed
#Scenario:TC004 Voucher iFrame-Cancel the Voucher payment

#Notes:
#Post payment authorization, iframe control will be given to XBE to trigger common post authorization flow

Scenario:TC001 Voucher iFrame-E2E Positive Flow
#Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987345  | 2000   | Hellan            | Bot              | AED      |
And Given Below payment template should be available in aeroPAY system
| Payment Template Name | Airline | Channels/Segments | Payment Option1 | Payment Option2 |
| Test1                 | G9      | Pay_Seg1          | Key1            |                 |
And  Below payment options should be available in aeroPAY system
| Payment Option1 | Payment Option Name | Payment Category | Supported Currencies | Airline |
| Key1            | VOUCHER             | VOUCHER          |                      |         |
And Below segments should be available in aeroSegment system
| Segment Name | Product | Channel Type | Aircraft Model | Passenger Count | Passenger Type | Member ID | Travel Agent ID | POS Country | Journey Type | Origin | Destination | Booking Class | Cabin Class |
| Pay_Seg1     | aeroPAY | XBE          | All            | 10              | All            |           | IT90987         |             | All          | MAA    | SHJ         | All           | All         |
When iFrameAPIRequest is invoked with below attributes from XBE to aeroPAY
"""
    {
  "referenceId": "Ref400",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
          "segmentCode": "",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                   {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADULT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "surcharges":[
          {
              "surchargeRPH":"1",
              "surchargeCode":"BG78",
              "description":"Test Surcharge",
              "refundableActions":[
                  {
                      "action":"MODIFICATION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ]
          }
      ],
      "taxes":[
          {
              "taxRPH":"1",
              "taxCode":"TG",
              "description":"Test Tax",
              "refundableActions":[
                  {
                      "action":"UNKNOWN_ACTION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ],
              "taxValue":500,
              "taxCurrencyCode":"AED"
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[""]
          }
      ],
      "penaltyType":"MANUALLY_ALTERED"
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
       "segmentCategory": "NORMAL_SEGMENT"
    }
  ],
  "emdDetails": [
    {
        "emdType":"UNKNOWN_EMD_TYPE",
        "emdGroup":"",
        "emdCode":"",
        "emdDescription":"",
        "isConsumedAtIssuance":"TRUE",
        "numberOfEmdsIssued":"",
        "reasonForIssuanceCode":"",
        "flightSegmentRPH":"",
        "paxRPH":"",
        "fareRPH":"",
        "taxRPH":"",
        "surchargeRPH":""
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William"
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
And RetrievePaymentOptionsRequest is invoked with below attributes from aeroPay to aeroPay itself
"""
    {
  "referenceId": "Ref400",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
    ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
        "segmentCode": "MAA/SHJ",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
        "seatLoadFactor":"",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                  {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                      }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[]
          }
      ]
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "segmentCategory":"NORMAL_SEGMENT"
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William",
          "languagePreferred":"English",
          "channel":"XBE",
          "posCountryCode": "",
          "posCityCode": "",
          "posStateCode": ""
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
#SegmentMatchingRequest API is triggered to aeroSegment by aeroPay
#SegmentMatchingResponse API is received by aeroPay from aeroSegment
#aeroPAY first searches for payment template matching airline(Received in iFrame request)-segment(Received from aeroSegment) combination.If no matching airline-segment template is found, then default template is picked.
#Payment options inside matching payment template is picked
And RetrievePaymentOptionsResponse is sent from aeroPay to aeroPay itself
And API Response should have Below values
"""
    {
    "referenceId":"Ref400",
    "availablePaymentOptions":[
        {
            "paymentType":"VOUCHER",
            "paymentSubType":"",
            "paymentAdditionalInfo":"",
            "paymentApiCall":"https://aero-pay-test-api.accelaero.cloud/aeropay.PaymentService/authorizevoucherPayment",
            "paymentFields":[]
        }
    ]
}
    """
And Retrieved Payment Options will be available in the iFrame for the user to select the form of payment
And Click on "Would you like to pay using Voucher/Gift Voucher Points" radio button
And Enter "VH00987345" in the field "Enter 10 digit Voucher/Gift Voucher ID"
When Click on "Apply Voucher" button
#ViewVoucherRQ is invoked from aeroPay to aeroCustomer
#ViewVoucherRS is received from aeroCustomer to aeroPay
And Field "The Redeemable value" should be equal to "AED 2000.00"
And Field "Balance to Pay" should be equal to "AED 0.00"
#"Redeem Voucher" button is enabled in Iframe at XBE
When Click on "Redeem Voucher" button
#VoucherAuthorizePay API request is constructed by aeroPay
And VoucherAuthorizePay API request is invoked with below attributes from aeroPAY to aeroPAY itself
"""
{
  "referenceId": "Ref400",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987345",
      "voucherRequestedAmount": 2000.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRQ is invoked from aeroPay to aeroCustomer
#RedeemVoucherRS is received from aeroCustomer to aeroPay
And VoucherPaymentAuthorizeRS is sent from aeroPAY to aeroPAY itself
And API Response should have Below values
    """
{
  "referenceId": "Ref400",
  "paymentReferenceId": "b050501d-4a3b-36ac-a397-3eb9d10233345",
  "passengerVoucherPaymentResponse": [
    {
      "passengerVoucherRPH": "1",
      "voucherPaymentStatus":  "VOUCHER_PAYMENT_APPROVED",
      "voucherAmountApproved": 2000.00,
      "voucherRemainingAmount": 0.00,
      "voucherPaymentCurrencyCode": "AED"
    }
  ]
}
    """
And iFrameAPIResponse is sent from aeroPay to XBE
And API Response should have Below values
"""
{
"referenceID": "Ref400"
"paymentReferenceId":"b050501d-4a3b-36ac-a397-3eb9d10233345",
"currencyCode":"AED",
"authorizedAmount":"2000",
"paymentStatus": "AUTHORIZED",
"paymentMetaData":[
  {
      "metaDataKey":"PAYMENT_CONFIRMATION_URL",
      "metaDataValue":""https://aero-pay-test-api.accelaero.cloud/aeropay.PaymentService/confirmPayment""
  }
]
}
"""
#iFrame control is transferred to XBE


Scenario:TC002 Voucher iFrame-E2E Negative Flow-ViewVoucherRq-Incorrect Pax detail
#Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987345  | 2000   | Hellan            | Bot              | AED      |
    And Given Below payment template should be available in aeroPAY system
        | Payment Template Name | Airline | Channels/Segments | Payment Option1 | Payment Option2 |
        | Test1                 | G9      | Pay_Seg1          | Key1            |                 |
    And  Below payment options should be available in aeroPAY system
        | Payment Option1 | Payment Option Name | Payment Category | Supported Currencies | Airline |
        | Key1            | VOUCHER             | VOUCHER          |                      |         |
    And Below segments should be available in aeroSegment system
        | Segment Name | Product | Channel Type | Aircraft Model | Passenger Count | Passenger Type | Member ID | Travel Agent ID | POS Country | Journey Type | Origin | Destination | Booking Class | Cabin Class |
        | Pay_Seg1     | aeroPAY | XBE          | All            | 10              | All            |           | IT90987         |             | All          | MAA    | SHJ         | All           | All         |
    When iFrameAPIRequest is invoked with below attributes from XBE to aeroPAY
"""
    {
  "referenceId": "Ref401",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
          "segmentCode": "",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                   {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADULT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "surcharges":[
          {
              "surchargeRPH":"1",
              "surchargeCode":"BG78",
              "description":"Test Surcharge",
              "refundableActions":[
                  {
                      "action":"MODIFICATION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ]
          }
      ],
      "taxes":[
          {
              "taxRPH":"1",
              "taxCode":"TG",
              "description":"Test Tax",
              "refundableActions":[
                  {
                      "action":"UNKNOWN_ACTION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ],
              "taxValue":500,
              "taxCurrencyCode":"AED"
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[""]
          }
      ],
      "penaltyType":"MANUALLY_ALTERED"
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
       "segmentCategory": "NORMAL_SEGMENT"
    }
  ],
  "emdDetails": [
    {
        "emdType":"UNKNOWN_EMD_TYPE",
        "emdGroup":"",
        "emdCode":"",
        "emdDescription":"",
        "isConsumedAtIssuance":"TRUE",
        "numberOfEmdsIssued":"",
        "reasonForIssuanceCode":"",
        "flightSegmentRPH":"",
        "paxRPH":"",
        "fareRPH":"",
        "taxRPH":"",
        "surchargeRPH":""
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William"
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
    And RetrievePaymentOptionsRequest is invoked with below attributes from aeroPay to aeroPay itself
"""
    {
  "referenceId": "Ref401",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
    ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
        "segmentCode": "MAA/SHJ",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
        "seatLoadFactor":"",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                  {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                      }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[]
          }
      ]
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "segmentCategory":"NORMAL_SEGMENT"
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William",
          "languagePreferred":"English",
          "channel":"XBE",
          "posCountryCode": "",
          "posCityCode": "",
          "posStateCode": ""
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
#SegmentMatchingRequest API is triggered to aeroSegment by aeroPay
#SegmentMatchingResponse API is received by aeroPay from aeroSegment
#aeroPAY first searches for payment template matching airline(Received in iFrame request)-segment(Received from aeroSegment) combination.If no matching airline-segment template is found, then default template is picked.
#Payment options inside matching payment template is picked
And RetrievePaymentOptionsResponse is sent from aeroPay to aeroPay itself
And API Response should have Below values
"""
    {
    "referenceId":"Ref401",
    "availablePaymentOptions":[
        {
            "paymentType":"VOUCHER",
            "paymentSubType":"",
            "paymentAdditionalInfo":"",
            "paymentApiCall":"https://aero-pay-test-api.accelaero.cloud/aeropay.PaymentService/authorizevoucherPayment",
            "paymentFields":[]
        }
    ]
}
"""
And Retrieved Payment Options will be available in the iFrame for the user to select the form of payment
And Click on "Would you like to pay using Voucher/Gift Voucher Points" radio button
And Enter "VH00111111" in the field "Enter 10 digit Voucher/Gift Voucher ID"
#User enters Invalid Voucher ID
When Click on "Apply Voucher" button
#ViewVoucherRQ is invoked from aeroPay to aeroCustomer
#Failure ViewVoucherRS is received from aeroCustomer to aeroPay
Then Error message "Invalid voucher ID" should be displayed in the iFrame at XBE
And Field "The Redeemable value" should be equal to "AED 0.00"
And Field "Balance to Pay" should be equal to "AED 2000.00"
#User should be able to cancel this voucher and add a new valid voucher



Scenario:TC003 Voucher iFrame-E2E Negative Flow-Authorize Failed
#Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987345  | 2000   | Hellan            | Bot              | AED      |
    And Given Below payment template should be available in aeroPAY system
        | Payment Template Name | Airline | Channels/Segments | Payment Option1 | Payment Option2 |
        | Test1                 | G9      | Pay_Seg1          | Key1            |                 |
    And  Below payment options should be available in aeroPAY system
        | Payment Option1 | Payment Option Name | Payment Category | Supported Currencies | Airline |
        | Key1            | VOUCHER             | VOUCHER          |                      |         |
    And Below segments should be available in aeroSegment system
        | Segment Name | Product | Channel Type | Aircraft Model | Passenger Count | Passenger Type | Member ID | Travel Agent ID | POS Country | Journey Type | Origin | Destination | Booking Class | Cabin Class |
        | Pay_Seg1     | aeroPAY | XBE          | All            | 10              | All            |           | IT90987         |             | All          | MAA    | SHJ         | All           | All         |
    When iFrameAPIRequest is invoked with below attributes from XBE to aeroPAY
"""
    {
  "referenceId": "Ref402",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
          "segmentCode": "",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                   {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADULT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "surcharges":[
          {
              "surchargeRPH":"1",
              "surchargeCode":"BG78",
              "description":"Test Surcharge",
              "refundableActions":[
                  {
                      "action":"MODIFICATION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ]
          }
      ],
      "taxes":[
          {
              "taxRPH":"1",
              "taxCode":"TG",
              "description":"Test Tax",
              "refundableActions":[
                  {
                      "action":"UNKNOWN_ACTION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ],
              "taxValue":500,
              "taxCurrencyCode":"AED"
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[""]
          }
      ],
      "penaltyType":"MANUALLY_ALTERED"
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
       "segmentCategory": "NORMAL_SEGMENT"
    }
  ],
  "emdDetails": [
    {
        "emdType":"UNKNOWN_EMD_TYPE",
        "emdGroup":"",
        "emdCode":"",
        "emdDescription":"",
        "isConsumedAtIssuance":"TRUE",
        "numberOfEmdsIssued":"",
        "reasonForIssuanceCode":"",
        "flightSegmentRPH":"",
        "paxRPH":"",
        "fareRPH":"",
        "taxRPH":"",
        "surchargeRPH":""
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William"
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
    And RetrievePaymentOptionsRequest is invoked with below attributes from aeroPay to aeroPay itself
"""
    {
  "referenceId": "Ref402",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
    ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
        "segmentCode": "MAA/SHJ",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
        "seatLoadFactor":"",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                  {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                      }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[]
          }
      ]
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "segmentCategory":"NORMAL_SEGMENT"
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William",
          "languagePreferred":"English",
          "channel":"XBE",
          "posCountryCode": "",
          "posCityCode": "",
          "posStateCode": ""
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
#SegmentMatchingRequest API is triggered to aeroSegment by aeroPay
#SegmentMatchingResponse API is received by aeroPay from aeroSegment
#aeroPAY first searches for payment template matching airline(Received in iFrame request)-segment(Received from aeroSegment) combination.If no matching airline-segment template is found, then default template is picked.
#Payment options inside matching payment template is picked
    And RetrievePaymentOptionsResponse is sent from aeroPay to aeroPay itself
    And API Response should have Below values
"""
    {
    "referenceId":"Ref402",
    "availablePaymentOptions":[
        {
            "paymentType":"VOUCHER",
            "paymentSubType":"",
            "paymentAdditionalInfo":"",
            "paymentApiCall":"https://aero-pay-test-api.accelaero.cloud/aeropay.PaymentService/authorizevoucherPayment",
            "paymentFields":[]
        }
    ]
}
    """
    And Retrieved Payment Options will be available in the iFrame for the user to select the form of payment
    And Click on "Would you like to pay using Voucher/Gift Voucher Points" radio button
    And Enter "VH00987345" in the field "Enter 10 digit Voucher/Gift Voucher ID"
    When Click on "Apply Voucher" button
#ViewVoucherRQ is invoked from aeroPay to aeroCustomer
#ViewVoucherRS is received from aeroCustomer to aeroPay
    And Field "The Redeemable value" should be equal to "AED 2000.00"
    And Field "Balance to Pay" should be equal to "AED 0.00"
#"Redeem Voucher" button is enabled in Iframe at XBE
    When Click on "Redeem Voucher" button
#VoucherAuthorizePay API request is constructed by aeroPay
    And VoucherAuthorizePay API request is invoked with below attributes from aeroPAY to aeroPAY itself
"""
{
  "referenceId": "Ref402",
  "passengerVoucherDetails": [
    {
      "passengerVoucherRPH": "1",
      "passengerFirstName": "Hellan",
      "PassengerSecondName": "Bot",
      "voucherCode": "VH00987345",
      "voucherRequestedAmount": 2000.00,
      "voucherAmountCurrencyCode": "AED"
    }
  ]
}
    """
#RedeemVoucherRQ is invoked from aeroPay to aeroCustomer
#RedeemVoucherRequest failed at aeroCustomer due to technical error
    And VoucherPaymentAuthorizeRS is sent from aeroPAY to aeroPAY itself
    And  HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "RedeemVoucherRequest failed at aeroCustomer due to technical reason"
    And iFrameAPIResponse is sent from aeroPay to XBE
    And HTTPS status code should be "400"
    Then No API Response
    And Error description in the response message header name "grpc-message" should be "RedeemVoucherRequest failed at aeroCustomer due to technical reason"
    Then Error message "RedeemVoucherRequest failed.Try again" should be displayed in the iFrame at XBE
#iFrame control is transferred to XBE



Scenario:TC004 Voucher iFrame-Cancel the Voucher payment
#Given Customer Voucher related information at aeroCustomer
#      | voucherCode | amount | consumerFirstName | consumerLastName | currency |
#      | VH00987345  | 2000   | Hellan            | Bot              | AED      |
    And Given Below payment template should be available in aeroPAY system
        | Payment Template Name | Airline | Channels/Segments | Payment Option1 | Payment Option2 |
        | Test1                 | G9      | Pay_Seg1          | Key1            |                 |
    And  Below payment options should be available in aeroPAY system
        | Payment Option1 | Payment Option Name | Payment Category | Supported Currencies | Airline |
        | Key1            | VOUCHER             | VOUCHER          |                      |         |
    And Below segments should be available in aeroSegment system
        | Segment Name | Product | Channel Type | Aircraft Model | Passenger Count | Passenger Type | Member ID | Travel Agent ID | POS Country | Journey Type | Origin | Destination | Booking Class | Cabin Class |
        | Pay_Seg1     | aeroPAY | XBE          | All            | 10              | All            |           | IT90987         |             | All          | MAA    | SHJ         | All           | All         |
    When iFrameAPIRequest is invoked with below attributes from XBE to aeroPAY
"""
    {
  "referenceId": "Ref403",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
  ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
          "segmentCode": "",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                   {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADULT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "surcharges":[
          {
              "surchargeRPH":"1",
              "surchargeCode":"BG78",
              "description":"Test Surcharge",
              "refundableActions":[
                  {
                      "action":"MODIFICATION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ]
          }
      ],
      "taxes":[
          {
              "taxRPH":"1",
              "taxCode":"TG",
              "description":"Test Tax",
              "refundableActions":[
                  {
                      "action":"UNKNOWN_ACTION",
                      "allowedPaxTypes":["ADULT"]
                  }
              ],
              "taxValue":500,
              "taxCurrencyCode":"AED"
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[""]
          }
      ],
      "penaltyType":"MANUALLY_ALTERED"
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
       "segmentCategory": "NORMAL_SEGMENT"
    }
  ],
  "emdDetails": [
    {
        "emdType":"UNKNOWN_EMD_TYPE",
        "emdGroup":"",
        "emdCode":"",
        "emdDescription":"",
        "isConsumedAtIssuance":"TRUE",
        "numberOfEmdsIssued":"",
        "reasonForIssuanceCode":"",
        "flightSegmentRPH":"",
        "paxRPH":"",
        "fareRPH":"",
        "taxRPH":"",
        "surchargeRPH":""
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William"
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
 And RetrievePaymentOptionsRequest is invoked with below attributes from aeroPay to aeroPay itself
"""
    {
  "referenceId": "Ref403",
  "paxDetails": [
    {
      "paxType": "ADT",
      "paxRPH": "1",
      "accompaniedAdultRPH": "",
      "loyaltyId": ""
    }
    ],
  "ownerAgency": {
    "agencyCode": "",
    "agencyName": "",
    "agencyCountryCode": "",
    "agencyIataCode": "",
    "agencyStationCode": ""
  },
  "transactionAgency": {
    "agencyCode": "IT90987",
    "agencyName": "ABC Tour",
    "agencyCountryCode": "IN",
    "agencyIataCode": "9020442",
    "agencyStationCode": "TN"
  },
  "itinerarySegment": [
    {
      "segmentRPH": "1",
      "tripOrigin": {
        "airportCode": "MAA",
        "countryCode": "IN",
        "stateCode": "TN",
        "cityCode": ""
      },
      "tripDestination": {
        "airportCode": "SHJ",
        "countryCode": "AE",
        "stateCode": "",
        "cityCode": ""
      },
      "tripViaPoints": [
        {
          "airportCode": "BOM",
          "countryCode": "IN",
          "stateCode": "",
          "cityCode": ""
        }
      ],
      "journeyType":"ONE_WAY",
      "tripType":"INTERNATIONAL",
      "flightSegments": [
        {
          "flightNumber": {
              "marketingAirlineDesignator":"G9",
              "marketingFlightNumber":"1239",
              "operatingAirlineDesignator":"",
              "operatingFlightNumber":""
          },
        "segmentCode": "MAA/SHJ",
        "bookingClassCode":"AA",
        "cabinClassCode":"Y",
        "seatLoadFactor":"",
          "origin": {
            "airportCode": "MAA",
            "countryCode": "IN",
            "stateCode": "TN",
            "cityCode": ""
          },
          "destination": {
            "airportCode": "SHJ",
            "countryCode": "AE",
            "stateCode": "",
            "cityCode": ""
          },
          "localDepartureDateTime": "XT01:00",
          "zuluDepartureDateTime": "XT02:30",
          "localArrivalDateTime": "X+1T00:00",
          "zuluArrivalDateTime": "X+1T02:20",
          "departureTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "arrivalTerminal": {
            "terminalName": "T1 Terminal",
            "terminal": "T1"
          },
          "aircraftModel": {
            "modelNumber": "320",
            "modelType": "A"
          },
          "flightSegmentRPH": "1"
        }
      ]
    }
  ],
  "priceDetails": {
      "totalPrice":2000,
      "paymentCurrencyCode":"AED",
      "paymentCollectedCarrierCode":"G9",
      "paxPriceOnds":[
          {
              "paxRPHs":["1"],
              "flightSegmentRPHs":["1"],
              "quotedFares":[
                  {
                      "fareRPH":"1",
                      "value":1000,
                      "currencyCode":"AED"
                  }
              ],
              "quotedSurcharges":[
                  {
                      "surchargeRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "quotedTaxes":[
                  {
                      "taxRPH":"1",
                      "value":500,
                      "currencyCode":"AED"
                  }
              ],
              "priceOnd":""
          }
      ],
      "fares":[
          {
              "fareRPH":"1",
              "fareRuleRPH":"1",
              "bookingClassCode":"AA",
              "validities":[
                  {
                      "fromDate":"X-1T01:00",
                      "toDate":"X+20T01:00",
                      "validityType":"FLIGHT_VALIDITY",
                      "journeyDirection":"INBOUND"
                      }
              ],
              "fareRate":{
                  "currencyCode":"AED",
                  "fareValues":[
                      {
                          "segmentCode":"MAA/SHJ",
                          "paxType":"ADT",
                          "value":1000,
                          "fareValueType":"VALUE",
                          "baseValuePaxType":"ADULT"
                      }
                  ]
              }
          }
      ],
      "fareRules":[
          {
              "fareRuleRPH":"1",
              "fareBasisCode":"GV10KJ",
              "fareRuleType":"NORMAL_FARE_RULE",
              "applicableCarrierCodes":["G9"],
              "applicableFlightNumbers":[]
          }
      ]
  },
  "paxFlightSegments": [
    {
        "paxRPH":"1",
        "flightSegmentRPH":"1",
        "segmentCategory":"NORMAL_SEGMENT"
    }
  ],
  "paymentMetaData": {
      "userMetaData":{
          "userId":"GSA3456",
          "userName":"William",
          "languagePreferred":"English",
          "channel":"XBE",
          "posCountryCode": "",
          "posCityCode": "",
          "posStateCode": ""
      },
      "otherMetaData":[
          {
              "metaDataKey":"",
              "metaDataValue":""
          }
      ]
  }
}
"""
#SegmentMatchingRequest API is triggered to aeroSegment by aeroPay
#SegmentMatchingResponse API is received by aeroPay from aeroSegment
#aeroPAY first searches for payment template matching airline(Received in iFrame request)-segment(Received from aeroSegment) combination.If no matching airline-segment template is found, then default template is picked.
#Payment options inside matching payment template is picked
    And RetrievePaymentOptionsResponse is sent from aeroPay to aeroPay itself
    And API Response should have Below values
"""
    {
    "referenceId":"Ref403",
    "availablePaymentOptions":[
        {
            "paymentType":"VOUCHER",
            "paymentSubType":"",
            "paymentAdditionalInfo":"",
            "paymentApiCall":"https://aero-pay-test-api.accelaero.cloud/aeropay.PaymentService/authorizevoucherPayment",
            "paymentFields":[]
        }
    ]
}
    """
 And Retrieved Payment Options will be available in the iFrame for the user to select the form of payment
 And Click on "Would you like to pay using Voucher/Gift Voucher Points" radio button
 And Enter "VH00987345" in the field "Enter 10 digit Voucher/Gift Voucher ID"
 When Click on "Apply Voucher" button
#ViewVoucherRQ is invoked from aeroPay to aeroCustomer
#ViewVoucherRS is received from aeroCustomer to aeroPay
And Field "The Redeemable value" should be equal to "AED 2000.00"
And Field "Balance to Pay" should be equal to "AED 0.00"
#"Redeem Voucher" button is enabled in Iframe at XBE
When Click on "Cancel" link
#User can again select to pay with voucher
Then Click on "Would you like to pay using Voucher/Gift Voucher Points" radio button
And Enter "VH00987345" in the field "Enter 10 digit Voucher/Gift Voucher ID"
When Click on "Apply Voucher" button
