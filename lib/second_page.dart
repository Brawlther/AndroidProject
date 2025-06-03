import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

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
    loadData();
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
    void checkLaunchURLSupport(Uri uri) async{
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
      else {
        var snackBar = SnackBar(content: Text("${uri.scheme} is not supported on this device"));
        setState((){
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    }

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
          Text(style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),"Welcome Back $loginName"),
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText:"First Name",
              border: OutlineInputBorder()
            ),
            onChanged: (value) async {
              saveData("firstName", value);
            }
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText:"Last Name",
              border: OutlineInputBorder()
            ),
            onChanged: (value) async {
              saveData("lastName", value);
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
                      saveData("phone", value);
                    }
                  )),
              IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  final phoneURI = Uri(scheme: 'tel', path: _phoneController.text);
                  checkLaunchURLSupport(phoneURI);
                },
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  final messageURI = Uri(
                      scheme: 'sms',
                      path: _phoneController.text,
                      queryParameters: <String, String>{
                        'body': 'Hello, ${_firstNameController.text}!'
                      }
                  );
                  checkLaunchURLSupport(messageURI);
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
                      saveData("email", value);
                    }
                  )),
              IconButton(
                icon: const Icon(Icons.mail),
                onPressed: () {
                  final emailURI = Uri(
                      scheme: 'mailto',
                      path: _emailController.text,
                      queryParameters: {
                        'subject': 'Greeting',
                        'body': 'Hello, ${_firstNameController.text}!'
                      }
                  );
                  checkLaunchURLSupport(emailURI);
                },
              )
            ],
          )
        ])
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }

  void loadData() async{
    final firstName = await getEncryptedSharedPreferencesByKey("firstName"); //firstName
    final lastName = await getEncryptedSharedPreferencesByKey("lastName"); //lastName
    final phone = await getEncryptedSharedPreferencesByKey("phone"); //phone
    final email = await getEncryptedSharedPreferencesByKey("email"); //email
    //update loaded information to the TextFields
    setState((){
      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _phoneController.text = phone;
      _emailController.text = email;
    });
  }

  Future<String> getEncryptedSharedPreferencesByKey(key) async {
    String value = await ePrefs.getString(key);
    return value;
  }

  void saveData(String key, String value) async{
    await ePrefs.setString(key, value);
  }
}