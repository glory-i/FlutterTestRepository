import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String? username;
  late String? password;
  late String? goal;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _passwordVisible;

  final listOfItems =["Lose Weight", "Maintain Weight", "Gain Weight"];

  @override
  void initState() {
    _passwordVisible = false;
    username = '';
    password = '';
    goal = 'Lose Weight';

  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(
              child: Row(
                children: [Text(username!), SizedBox(height: 10.0, width: 10.0), Text(password!), SizedBox(height: 10.0, width: 10.0), Text(goal!),],
              ),
            ),),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Enter your Username',
                suffixIcon: IconButton(onPressed: () {_usernameController.clear();}, icon: Icon(Icons.clear))


              ),
            ),

            SizedBox( width: MediaQuery.of(context).size.width, height: 20.0),

            TextField(
              obscureText: !_passwordVisible,
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  suffixIcon: IconButton(onPressed: ()
                  {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }, icon: _passwordVisible? Icon(Icons.visibility) : Icon(Icons.visibility_off))


              ),
            ),

            SizedBox( width: MediaQuery.of(context).size.width, height: 20.0),

            DropdownButton<String>(
                hint: Text('What is your Goal?'),
                value: goal,
                items: listOfItems.map(buildMenuItem).toList(), onChanged: (value)
            {
              setState(() {
                goal = value;
              });
            }),

            MaterialButton(onPressed: (){
              setState(() {
                username = _usernameController.text;
                password = _passwordController.text;
              });
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

DropdownMenuItem<String> buildMenuItem(String item){
  return DropdownMenuItem<String>(value: item, child: Text(item));
}