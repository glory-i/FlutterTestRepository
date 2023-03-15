import 'package:flutter/material.dart';
import 'package:receive_input/HomePage.dart';
import 'package:receive_input/MonnifyResponse.dart';
import 'package:http/http.dart' as http;
import 'package:receive_input/Models/PaymentRequest.dart';
import 'dart:convert';
import 'package:receive_input/Models/PaymentResponse.dart';



class Monnify extends StatefulWidget {
  const Monnify({Key? key}) : super(key: key);

  @override
  State<Monnify> createState() => _MonnifyState();
}

class _MonnifyState extends State<Monnify> {

  final _amountController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _paymentReferenceController = TextEditingController();
  final _paymentDescriptionController = TextEditingController();
  final _currencyCodeController = TextEditingController();
  final _contractCodeController = TextEditingController();
  final _redirectUrlController = TextEditingController();




  double? amount;
  String? customerName ;
  String? customerEmail;
  String? paymentReference ;
  String? paymentDescription ;
  String? currencyCode;
  String? contractCode;
  String? redirectUrl;


  @override
  void initState() {
    super.initState();

    //amount = 0.0;
    //customerName = '';
  }

@override
  void dispose() {

    _amountController.dispose();
    _customerNameController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    amount = double.parse(_amountController.text);
                  });
                },
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    hintText: 'Enter Amount For this Transaction',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    customerName = _customerNameController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _customerNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name',
                  hintText: 'Enter Customer Name',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    customerEmail = _customerEmailController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _customerEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Email',
                  hintText: 'Enter Customer Email',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    paymentReference = _paymentReferenceController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _paymentReferenceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Payment Reference',
                  hintText: 'Enter Payment Reference',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    paymentDescription = _paymentDescriptionController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _paymentDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Payment Description',
                  hintText: 'Enter Payment Description',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    currencyCode = _currencyCodeController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _currencyCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Currency Code',
                  hintText: 'Enter Currency Code',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    contractCode = _contractCodeController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _contractCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contract Code',
                  hintText: 'Enter Contract Code',
                ),
              ),

              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value){
                  setState(() {
                    redirectUrl = _redirectUrlController.text;
                  });
                },
                keyboardType: TextInputType.text,
                controller: _redirectUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Redirect Url',
                  hintText: 'Enter Redirect Url',
                ),
              ),

              MaterialButton(onPressed: ()
              async {
                var res = await postData(PaymentRequest(amount: amount, customerName: customerName, customerEmail: customerEmail, paymentReference: paymentReference, paymentDescription: paymentDescription, currencyCode: currencyCode, contractCode: contractCode));
                if(res!=null)
                {
                  if(res.requestSuccessful==true)
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonnifyResponse(paymentResponse: res,) ));
                  }
                }
              },
                  color: Colors.green[300],
                  child: Text('LOGIN', style: TextStyle(color: Colors.black),)
              ),

              MaterialButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonnifyResponse() ));
              },
                  color: Colors.green[300],
                  child: Text('SWITCH', style: TextStyle(color: Colors.black),)
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

Future<PaymentResponse?> postData(PaymentRequest model) async{

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
    return null;
  }
}

