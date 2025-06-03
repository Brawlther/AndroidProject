import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late EncryptedSharedPreferences ePrefs;
  late String loginName;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override //same as in java
  void initState(){
    super.initState(); //call the parent initState()
    _initializeApp();
  }

  void _initializeApp() async {
    ePrefs = EncryptedSharedPreferences();
    loginName = DataRepository.loginName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(
      // TRY THIS: Try changing the color here to a specific color (to
      // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      // change color while the other colors stay the same.
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
    ), body
        :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 15,
        children: <Widget>[
          Text(style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),"Welcome Back $loginName"),
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText:"First Name",
              border: OutlineInputBorder()
            ),
            onChanged: (value) async {
              await ePrefs.setString("firstName", value);
            }
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText:"Last Name",
              border: OutlineInputBorder()
            ),
            onChanged: (value) async {
              await ePrefs.setString("lastName", value);
            }
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder()
                    ),
                    onChanged: (value) async {
                      await ePrefs.setString("phone", value);
                    }
                  )),
              IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  // Handle phone icon tap if needed
                },
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  // Handle phone icon tap if needed
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder()
                    ),
                    onChanged: (value) async {
                      await ePrefs.setString("email", value);
                    }
                  )),
              IconButton(
                icon: const Icon(Icons.mail),
                onPressed: () {
                  // Handle phone icon tap if needed
                },
              )
            ],
          )
        ])
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}