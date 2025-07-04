import 'package:flutter/material.dart';
import 'Database.dart';
import 'InputItemRow.dart';
import 'ToDoItem.dart';
import 'MyListView.dart';

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
  late TextEditingController _controllerName; //late - Constructor in initState()
  late final AppDatabase database;
  List<ToDoItem> items = [];


  @override //same as in java
  initState() {
    super.initState(); //call the parent initState()
    _controllerName = TextEditingController(); //our late constructor
    _initAsync();

  }

  Future<void> _initAsync() async {
    database = await initDatabase();
    updateListView();
  }

  @override
  void dispose()
  {
    super.dispose();
    _controllerName.dispose();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              const SizedBox(height: 15),
              //First Row - Encapsulated as a component
              InputItemRow(
                controller_01: _controllerName,
                callback: () async {
                    addItem(
                      null,
                      _controllerName.text.trim()
                    );
                    //Clear the TextFields
                    clearTextFields();
                  }),
              const SizedBox(height: 15),
              //List View - Encapsulated as a component
              Expanded(
                child: MyListView(list: items, onLongPressItem: (index) => removeItem(index))
              ),
          ],
        ),
      )
    );
  }

  Future<AppDatabase> initDatabase() async {
    return await $FloorAppDatabase.databaseBuilder('week8lab_database.db').build();
  }

  Future<void> addItem(int? itemId, String itemName) async {
    await database.itemDao.insertItem(ToDoItem(itemId, itemName));
    updateListView();
  }

  void updateListView() async {
    //fetch updated item list from the database
    database.itemDao.findAllItems().then(
        (fetchedItems){
          setState(() {
            //re-render the item list
            items = fetchedItems;
          });
        }
    );
  }

  void clearTextFields(){
    _controllerName.text = "";
  }

  void removeItem(int index){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Item', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        content: const Text('Remove this item?', style: TextStyle(fontSize: 18),textAlign: TextAlign.center),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Yes
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, '');
                  //delete item
                  await database.itemDao.deleteItem(items[index]);
                  updateListView();
                },
                child: const Text('Yes'),
              ),
              //No
              TextButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                child: const Text('No'),
              ),
            ],
          )
        ],
      ),
    );
  }
}