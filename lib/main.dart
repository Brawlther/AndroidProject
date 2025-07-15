import 'package:flutter/material.dart';
import 'Database.dart';
import 'DetailsPage.dart';
import 'ListPage.dart';
import 'ToDoItem.dart';
import 'InputItemColumn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Responsive Layout Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerQuantity;
  late final AppDatabase database;
  List<ToDoItem> items = [];
  ToDoItem? selectedItem;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerQuantity = TextEditingController();
    _initAsync();
  }

  Future<void> _initAsync() async {
    database = await initDatabase();
    updateListView();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          InputItemColumn(
            controller_01: _controllerName,
            controller_02: _controllerQuantity,
            callback: () async {
              addItem(
                null,
                _controllerName.text.trim(),
                int.parse(_controllerQuantity.text.trim()),
              );
              clearTextFields();
            },
          ),
          const SizedBox(height: 40),
          Expanded(
            child: isLandScape(context)
                ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListPage(
                    items: items,
                    onSelectItem: (item) => showItemDetail(item.id!),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DetailsPage(
                    selectedItem: selectedItem,
                    onDelete: () {
                      removeItemById(selectedItem!.id!);
                      setState(() {
                        selectedItem = null;
                      });
                    },
                    onClose: () {
                      setState(() {
                        selectedItem = null;
                      });
                    },
                  ),
                ),
              ],
            )
                : (selectedItem == null
                ? ListPage(
              items: items,
              onSelectItem: (item) => showItemDetail(item.id!),
            )
                : DetailsPage(
              selectedItem: selectedItem,
              onDelete: () {
                removeItemById(selectedItem!.id!);
                setState(() {
                  selectedItem = null;
                });
              },
              onClose: () {
                setState(() {
                  selectedItem = null;
                });
              },
            )),
          ),
        ],
      ),
    );
  }

  Future<AppDatabase> initDatabase() async {
    return await $FloorAppDatabase.databaseBuilder('week8lab_database.db').build();
  }

  Future<void> addItem(int? itemId, String itemName, int quantity) async {
    await database.itemDao.insertItem(ToDoItem(itemId, itemName, quantity));
    updateListView();
  }

  bool isLandScape(BuildContext context){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return (width>height) && (width > 720);
  }

  void removeItemById(int id) async {
    final item = await database.itemDao.findItemById(id);
    if (item != null) {
      await database.itemDao.deleteItem(item);
      updateListView();
    }
  }

  void updateListView() async {
    final fetchedItems = await database.itemDao.findAllItems();
    setState(() {
      items = fetchedItems;
    });
  }

  void showItemDetail(int id) async {
    final item = await database.itemDao.findItemById(id);
    setState(() {
      selectedItem = item;
    });
  }

  void clearTextFields() {
    _controllerName.clear();
    _controllerQuantity.clear();
  }
}
