import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //cache object
  late SharedPreferences sharedPreferences;
  late TextEditingController _controllerLogin; //late - Constructor in initState()
  late TextEditingController _controllerPasswd;
  String imagePath = "";

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _controllerLogin = TextEditingController(); //our late constructor
    _controllerPasswd = TextEditingController();
    //Initialize the app
    _initializeApp();
    //local
    imagePath = "./images/question-mark.png";
  }
  //Initialize the application
  void _initializeApp() async {
    //Get the singleton access from SharedPreferences
    sharedPreferences = await SharedPreferences.getInstance();
    //Initialize TextFields with loaded cache information (if not empty)
    _loadSavedLogin();
  }
  //Load username and password from cache
  void _loadSavedLogin(){
    final retrievedUsername = getSharedPreferencesByKey("loginName"); //username
    final retrievedPasswd = getSharedPreferencesByKey("loginPasswd"); //password
    if(retrievedUsername != "" || retrievedPasswd !=""){
      //Initialize the SnackBar
      var snackBar = const SnackBar( content: Text("Account retrieval success.") );
      //update loaded information to the TextFields
      setState((){
        _controllerLogin.text = retrievedUsername;
        _controllerPasswd.text = retrievedPasswd;
        ScaffoldMessenger.of(context).showSnackBar(snackBar); //Show the SnackBar to notice user
      });
    }
  }

  String getSharedPreferencesByKey(key){
    if (sharedPreferences.containsKey(key)){
      return sharedPreferences.getString(key)!;
    }
    return "";
  }


  @override
  void dispose()
  {
    super.dispose();
    _controllerLogin.dispose();    // clean up memory
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controllerLogin,
               decoration: const InputDecoration(
                labelText:"Login",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(controller: _controllerPasswd,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                labelText:"Password",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                style:ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  minimumSize: const Size(100,60),
                  foregroundColor: Colors.blue
                ),onPressed: buttonClicked,
                child: const Text("Login")
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
                child: Image.asset(imagePath,width: 300, height: 300))
              //child: Image.network(imageUrl,width: 300, height: 300))
          ],
        ),
      )
    );
  }

  //this runs when you click the button
  void buttonClicked(){
    var inputUsername = _controllerLogin.value.text;
    var inputPasswd = _controllerPasswd.value.text;
    if (inputPasswd == "QWERTY123"){
      setState(() {
        // local
        imagePath = "./images/idea.png";
      });
    }
    else{
      setState(() {
        // local
        imagePath = "./images/stop.png";
      });
    }
    //Popup for saving / clearing account information
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Almost There', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        content: const Text('Remember your account?', style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Save Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context, '');
                  saveLoginInfo(inputUsername,inputPasswd); //save event
                },
                child: const Text('Yes'),
              ),
              //Clear Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context, '');
                  clearLoginInfo(); //clear event
                },
                child: const Text('No'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void saveLoginInfo(inputUsername, inputPasswd) {
    sharedPreferences.setString("loginName", inputUsername);
    sharedPreferences.setString("loginPasswd", inputPasswd);
  }
  void clearLoginInfo() {
    sharedPreferences.remove("loginName");
    sharedPreferences.remove("loginPasswd");
  }
}