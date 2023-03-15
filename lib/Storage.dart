import 'package:flutter/material.dart';
import 'package:receive_input/Models/SecureStorage.dart';

class Storage extends StatefulWidget {
  const Storage({Key? key}) : super(key: key);

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {

  final _usernameController = TextEditingController();
  String? valueString;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("FLUTTER SECURE STORAGE", style: TextStyle(color: Colors.black),),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your Username',

                ),
              ),
            ),

            MaterialButton(onPressed: () async{
                  await SecureStorage.setString(_usernameController.text);

            },
                color: Colors.green[300],
                child: Text('SAVE', style: TextStyle(color: Colors.black),)

            ),

            MaterialButton(onPressed: () async{
              await getString();
            },
                color: Colors.green[300],
                child: Text('VIEW', style: TextStyle(color: Colors.black),)

            ),
            Text(valueString??"")

          ],
        ),

      ),

    );
  }


  Future getString() async{
    var str = await SecureStorage.getString();
    print(str);
    setState(() {
      valueString= str;
    });
  }

}
