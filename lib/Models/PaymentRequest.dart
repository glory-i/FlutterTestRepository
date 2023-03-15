// To parse this JSON data, do
//
//     final paymentRequest = paymentRequestFromJson(jsonString);

import 'dart:convert';

PaymentRequest paymentRequestFromJson(String str) => PaymentRequest.fromJson(json.decode(str));

String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());

class PaymentRequest {
  PaymentRequest({
    this.amount,
    this.customerName,
    this.customerEmail,
    this.paymentReference,
    this.paymentDescription,
    this.currencyCode,
    this.contractCode,
  });

  double? amount;
  String? customerName;
  String? customerEmail;
  String? paymentReference;
  String? paymentDescription;
  String? currencyCode;
  String? contractCode;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    amount: json["amount"],
    customerName: json["customerName"],
    customerEmail: json["customerEmail"],
    paymentReference: json["paymentReference"],
    paymentDescription: json["paymentDescription"],
    currencyCode: json["currencyCode"],
    contractCode: json["contractCode"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "customerName": customerName,
    "customerEmail": customerEmail,
    "paymentReference": paymentReference,
    "paymentDescription": paymentDescription,
    "currencyCode": currencyCode,
    "contractCode": contractCode,
  };
}
