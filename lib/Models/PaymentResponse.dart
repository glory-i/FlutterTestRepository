// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) => PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) => json.encode(data.toJson());

class PaymentResponse {
  PaymentResponse({
    this.requestSuccessful,
    this.responseMessage,
    this.responseCode,
    this.responseBody,
  });

  bool? requestSuccessful;
  String? responseMessage;
  String? responseCode;
  ResponseBody? responseBody;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
    requestSuccessful: json["requestSuccessful"],
    responseMessage: json["responseMessage"],
    responseCode: json["responseCode"],
    responseBody: json["responseBody"] == null ? null : ResponseBody.fromJson(json["responseBody"]),
  );

  Map<String, dynamic> toJson() => {
    "requestSuccessful": requestSuccessful,
    "responseMessage": responseMessage,
    "responseCode": responseCode,
    "responseBody": responseBody?.toJson(),
  };
}

class ResponseBody {
  ResponseBody({
    this.transactionReference,
    this.paymentReference,
    this.merchantName,
    this.apiKey,
    this.redirectUrl,
    this.enabledPaymentMethod,
    this.checkoutUrl,
  });

  String? transactionReference;
  String? paymentReference;
  String? merchantName;
  String? apiKey;
  String? redirectUrl;
  List<String>? enabledPaymentMethod;
  String? checkoutUrl;

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
    transactionReference: json["transactionReference"],
    paymentReference: json["paymentReference"],
    merchantName: json["merchantName"],
    apiKey: json["apiKey"],
    redirectUrl: json["redirectUrl"],
    enabledPaymentMethod: json["enabledPaymentMethod"] == null ? [] : List<String>.from(json["enabledPaymentMethod"]!.map((x) => x)),
    checkoutUrl: json["checkoutUrl"],
  );

  Map<String, dynamic> toJson() => {
    "transactionReference": transactionReference,
    "paymentReference": paymentReference,
    "merchantName": merchantName,
    "apiKey": apiKey,
    "redirectUrl": redirectUrl,
    "enabledPaymentMethod": enabledPaymentMethod == null ? [] : List<dynamic>.from(enabledPaymentMethod!.map((x) => x)),
    "checkoutUrl": checkoutUrl,
  };
}
