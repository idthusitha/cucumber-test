Feature: PAY2-34 -ADYEN cancel flow - Travel Agent Flow

#ScenariosCovered
#Scenario:2-34_TC001 CC Payment cancel_request API-Positive Validation
#Scenario:2-34_TC002 CC Payment cancel_request API-Negative Validation
#Scenario:2-34_TC003 CC Payment cancel_positive flow-When the channel is XBE or OTA
#Scenario:2-34_TC004 CC Payment cancel_Negative flow-Not approved at payment gateway-When the channel is XBE
#Scenario:2-34_TC005 CC Payment cancel_Resend the same cancel request which is already cancelled

  @PAY2_34_ADYEN_cancel_flow_Travel_Agent_Flow
  Scenario Outline:2-34_TC001 CC Payment cancel_request API-Positive Validation
    Given Information of the Payment Reference ID for which cancel request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status   | Channel |
      | 12ed1284-eac3-3104-8524-d917571007AA | TC200       | Authorization_Success | XBE     |
      | 12ed1284-eac3-3104-8524-d917571007AB | TC201       | Authorization_Success | OTA     |
    When CCCancel API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "<referenceId>",
  "paymentReferenceId": "<paymentReferenceId>",
  "cancelAuthorizationReason": "<cancelAuthorizationReason>",
  "paymentMetaData": {
  "userMetaData": {
  "userId": "<userId>",
  "userName": "<userName>"
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
    And  ADYEN cancel API Response should have Below values
    """
  {
  "paymentReferenceId": "<paymentReferenceId>",
  "paymentAuthorizeCancelConfirmation": "CANCELLED",
  "warnings ":[
  {
  "warningCode":"",
  "warningDetails":""
  }
  ]
  }
   """
    Examples:
      | # | referenceId | paymentReferenceId                   | cancelAuthorizationReason | userId  | userName |
      | 1 | TC200       | 12ed1284-eac3-3104-8524-d917571007AA | User Request              | GSA3456 | William  |
      | 2 | TC200       | 12ed1284-eac3-3104-8524-d917571007AA |                           |         |          |
      | 3 | TC201       | 12ed1284-eac3-3104-8524-d917571007AB |                           | GSA3456 | William  |

  @PAY2_34_ADYEN_cancel_flow_Travel_Agent_Flow
  Scenario Outline:2-34_TC002 CC Payment cancel_request API-Negative Validation
    Given Information of the Payment Reference ID for which cancel request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status   | Channel |
      | 12ed1284-eac3-3104-8524-d917571007AA | TC200       | Authorization_Success | XBE     |
      | 12ed1284-eac3-3104-8524-d917571007AB | TC201       | Authorization_Success | OTA     |
      | 12ed1284-eac3-3104-8524-d917571007AC | TC203       | Confirmation_Success  | XBE     |
      | 12ed1284-eac3-3104-8524-d917571007AD | TC204       | Unknown_Status        | XBE     |
    When CCCancel API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "<referenceId>",
  "paymentReferenceId": "<paymentReferenceId>",
  "cancelAuthorizationReason": "<cancelAuthorizationReason>",
  "paymentMetaData": {
  "userMetaData": {
  "userId": "<userId>",
  "userName": "<userName>"
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
      | # | referenceId | paymentReferenceId                   | cancelAuthorizationReason | userId  | userName | Response_Header_GRPCErrorDescription               |
      | 1 |             | 12ed1284-eac3-3104-8524-d917571007AA | User Request              | GSA3456 | William  | Mandatory.Parameter.referenceId.missing            |
      | 2 | TC400       |                                      |                           |         |          | Mandatory.Parameter.paymentReferenceId.missing     |
      | 3 | TC404       | 12ed1284-eac3-3104-8524-d917571007AD |                           | GSA3456 | William  | Invalid.Input.paymentReferenceId not  Authorized   |
      | 4 | TC464       | 12ed1284-eac3-3104-8524-d917571007AC | Incorrect Details         | GSA3456 | William  | Invalid.Input.paymentReferenceId already confirmed |


  Scenario:2-34_TC003 CC Payment cancel_positive flow-When the channel is XBE or OTA
    Given Information of the Payment Reference ID for which cancel request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status   | Channel |
      | 12ed1284-eac3-3104-8524-d917571007AA | TC200       | Authorization_Success | XBE     |
    When CCCancel API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "TC890343434",
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007AA",
  "cancelAuthorizationReason": "Test120",
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
#aeroPay sends the cancel request to the payment gateway
#Success response is received from the payment gateway
#aeroPay send the blockCreditRollback request to aeroAgent through Kafka
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "200"
    And  ADYEN cancel API Response should have Below values
    """
  {
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007AA",
  "paymentAuthorizeCancelConfirmation": "CANCELLED",
  "warnings ":[
  {
  "warningCode":"",
  "warningDetails":""
  }
  ]
  }
   """


  Scenario:2-34_TC004 CC Payment cancel_Negative flow-Not approved at payment gateway-When the channel is XBE
    Given Information of the Payment Reference ID for which cancel request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status   | Channel |
      | 12ed1284-eac3-3104-8524-d917571007NA | TC000       | Authorization_Success | XBE     |
    When CCCancel API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "TC890343489",
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007NA",
  "cancelAuthorizationReason": "Test120",
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
#aeroPay sends the cancel request to the payment gateway
#Failure response is received from the payment gateway
#Below response is sent from aeroPay to the consuming application
    Then HTTPS status code should be "400"
    Then No API Response
    And  Read errorMessageDesc from payment gateway and print in responseHeaders['grpc-message']
  #The error response from payment gateway should be shown to the consuming application



  Scenario:2-34_TC005 CC Payment cancel_Resend the same cancel request which is already cancelled
    Given Information of the Payment Reference ID for which cancel request has to be sent
      | paymentReferenceId                   | referenceId | Payment_Auth_Status    | Channel |
      | 12ed1284-eac3-3104-8524-d917571007LA | TC200       | Authorization_Cancelled| XBE     |
    When CCCancel API request is invoked with below attributes to aeroPAY
    """
{
  "referenceId": "TC8903445443434",
  "paymentReferenceId": "12ed1284-eac3-3104-8524-d917571007LA",
  "cancelAuthorizationReason": "Authorization cancel",
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
    And  ADYEN cancel API Response should have Below values
    """
  {
  "paymentReferenceId": 12ed1284-eac3-3104-8524-d917571007LA",
  "paymentAuthorizeCancelConfirmation": "CANCELLED",
  "warnings ":[
  {
  "warningCode":"",
  "warningDetails":""
  }
  ]
  }
   """



