import 'package:flutter/material.dart';
import 'package:receive_input/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:receive_input/Models/PaymentRequest.dart';
import 'dart:convert';
import 'package:receive_input/Models/PaymentResponse.dart';

import 'Models/Results.dart';



class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  RandomUsers? users;

  @override
  void initState() {
    fetchUsers(15, "male");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("FEXLIXIFIED APP")),),
      body: users ==null? Center(child: CircularProgressIndicator()) :
      ListView.builder(
          itemCount: users?.results?.length,
          itemBuilder: (context, index){
            final user = users?.results![index];
            final email = user?.email;
            final name = user?.name?.first;
            final imageUrl = user?.picture?.thumbnail;

        return ListTile(
              leading: CircleAvatar(child: Image.network(imageUrl??"")),
              title: Text(name?? ""),
              subtitle: Text(email??""),
        );
      }),
      /*floatingActionButton: FloatingActionButton(onPressed:()
      async {
        var randomUsers = await fetchUsers(15,"female");
        setState(()  {
          users = randomUsers;
        });
        //fetchUsers(15,"female");

      }),*/
    );
  }





  Future<void> fetchUsers(int? result, String? gender) async{
    const String baseUrl = "https://randomuser.me/api/";
    try
    {
      var response = await http.get(Uri.parse("${baseUrl}?results=${result??1}&gender=${gender??'male'}"));
      var randomUsers = randomUsersFromJson(response.body);

      setState(() {
        users = randomUsers;
      });


      /*var body = response.body;
      var json = jsonDecode(body);
      setState(() {
        users = randomUsers;
      });*/
      print(response.body);

      //return randomUsers;
    }
    catch(e)
    {
      print(e);
      //return new RandomUsers();
    }
  }
}




