import 'package:flutter/material.dart';
import 'components/TextedImage_Bottom.dart';
import 'components/TextedImage_Flow.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 3 Lab Demo'),
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
  String imageBasePath = "images/Week3";
  String imageSuffix = ".jpg";
  final SizedBox mediumSizedBox = const SizedBox(height: 20);
  final SizedBox largeSizedBox = const SizedBox(height: 40);

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
  }


  @override
  void dispose()
  {
    super.dispose();
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
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Title
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BROWSE CATEGORIES",
                    style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              largeSizedBox,
              //Description
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              largeSizedBox,
              //Section 1
              Column(
                children: [
                  const Text(
                    "BY MEAT",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  mediumSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextedImageFlow(imageFileName: getImagePath("Beef"),label:"Beef"),
                      TextedImageFlow(imageFileName: getImagePath("Chicken"),label:"Chicken"),
                      TextedImageFlow(imageFileName: getImagePath("Pork"),label:"Pork"),
                      TextedImageFlow(imageFileName: getImagePath("Seafood"),label:"Seafood")
                    ],
                  )
                ],
              ),
              largeSizedBox,
              //Section 2
              Column(
                children: [
                  const Text(
                    "BY COURSE",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  mediumSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextedImageBottom(label:"Main Dishes", imageFileName:getImagePath("MainDishes")),
                      TextedImageBottom(label:"Salad Recipes", imageFileName:getImagePath("SaladRecipes")),
                      TextedImageBottom(label:"Side Dishes", imageFileName:getImagePath("SideDishes")),
                      TextedImageBottom(label:"Crockpot", imageFileName:getImagePath("Crockpot"))
                    ],
                  )
                ],
              ),
              largeSizedBox,
              //Section 3
              Column(
                children: [
                  const Text(
                    "BY DESSERT",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  mediumSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextedImageBottom(label:"Ice Cream", imageFileName:getImagePath("IceCream")),
                      TextedImageBottom(label:"Brownies", imageFileName:getImagePath("Brownies")),
                      TextedImageBottom(label:"Pies", imageFileName:getImagePath("Pies")),
                      TextedImageBottom(label:"Cookies", imageFileName:getImagePath("Cookies"))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  String getImagePath(String imageName){
    return "$imageBasePath/$imageName$imageSuffix";
  }
}