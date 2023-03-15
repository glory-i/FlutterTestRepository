import 'package:flutter/material.dart';
import 'package:receive_input/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:receive_input/Models/PaymentRequest.dart';
import 'dart:convert';
import 'package:receive_input/Models/PaymentResponse.dart';



class MonnifyResponse extends StatefulWidget {

  PaymentResponse? paymentResponse;

  MonnifyResponse({Key? key, this.paymentResponse}) : super(key: key);

  @override
  State<MonnifyResponse> createState() => _MonnifyResponseState(paymentResponse);
}

class _MonnifyResponseState extends State<MonnifyResponse> {

  PaymentResponse? paymentResponse;
  _MonnifyResponseState(this.paymentResponse);


  final _transactionReferenceController = TextEditingController();
  final _merchantNameController = TextEditingController();
  final _paymentReferenceController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final _redirectUrlController = TextEditingController();




  String? transactionReference ;
  String? merchantName;
  String? paymentReference ;
  String? apiKey ;
  String? redirectUrl;


  @override
  void initState() {
    super.initState();
    _transactionReferenceController.text = paymentResponse?.responseBody?.transactionReference?? "";
    _merchantNameController.text = paymentResponse?.responseBody?.merchantName?? "";
    _paymentReferenceController.text = paymentResponse?.responseBody?.paymentReference?? "";
    _apiKeyController.text = paymentResponse?.responseBody?.apiKey?? "";
    _redirectUrlController.text = paymentResponse?.responseBody?.redirectUrl?? "";


    //amount = 0.0;
    //customerName = '';
  }

  @override
  void dispose() {

    _transactionReferenceController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.0,),


            SizedBox(height: 20.0,),

            TextField(
              keyboardType: TextInputType.text,
              controller: _transactionReferenceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
                hintText: '',
              ),
            ),

            SizedBox(height: 20.0,),

            TextField(
              keyboardType: TextInputType.text,
              controller: _merchantNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
                hintText: '',
              ),
            ),

            SizedBox(height: 20.0,),
            TextField(
              keyboardType: TextInputType.text,
              controller: _paymentReferenceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
                hintText: '',
              ),
            ),

            SizedBox(height: 20.0,),
            TextField(
              keyboardType: TextInputType.text,
              controller: _apiKeyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
                hintText: '',
              ),
            ),

            SizedBox(height: 20.0,),
            TextField(
              keyboardType: TextInputType.text,
              controller: _redirectUrlController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
                hintText: '',
              ),
            ),

            SizedBox(height: 20.0,),
            MaterialButton(onPressed: (
                )
            {
              //postData(PaymentRequest(amount: amount, customerName: transactionReference, customerEmail: merchantName, paymentReference: paymentReference, paymentDescription: apiKey, currencyCode: currencyCode, contractCode: contractCode));

            },
                color: Colors.green[300],
                child: Text('LOGIN', style: TextStyle(color: Colors.black),)
            )
          ],
        ),
      ),
    );






  }
}


Map<String, String> headers = {
  'Content-Type':'application/json',
  "Authorization" : "Basic TUtfVEVTVF9DSFZRRlJBN1NHOjZRSE1aMlBMQ1VHVDJUQzlNUFBEWTRXSFhQRERDWlBK"
};

postData(PaymentRequest model) async{

  try
  {
    var response = await
    http.post(Uri.parse("https://sandbox.monnify.com/api/v1/merchant/transactions/init-transaction"),
        headers: headers,
        body :jsonEncode({
          "amount" : model.amount,
          "customerName": model.customerName,
          "customerEmail": model.customerEmail,
          "paymentReference": model.paymentReference,
          "paymentDescription": model.paymentDescription,
          "currencyCode": model.currencyCode,
          "contractCode": model.contractCode,
          "redirectUrl": "https://my-merchants-page.com/transaction/confirm",
          "paymentMethods":["CARD","ACCOUNT_TRANSFER"]
        })
    );
    print(response.body);
    var res = paymentResponseFromJson(response.body);
    print(res.responseBody);
    return res;
  }
  catch (e){
    print(e);
  }
}

