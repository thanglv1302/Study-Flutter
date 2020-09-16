import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final category = Category.generateCategories;
  int indexCategory;
  final _scrollController = ScrollController();

  void initState() {
    indexCategory = 0;
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter <= 10) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
          Category.generateCategories[indexCategory].subCategories
              .addAll(SubCategory.generateSubCategories);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your \nConsutation',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(right: 5, top: 5, left: 20, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.withOpacity(0.5)),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    hintText: 'Search'),
                cursorColor: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Container(
              height: 30.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Category.generateCategories.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(
                          () {
                        for (var i = 0;
                        i < Category.generateCategories.length;
                        i++) {
                          if (i == index) {
                            category[i].isSelected = true;
                            indexCategory = i;
                          } else {
                            category[i].isSelected = false;
                          }
                        }
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(Category.generateCategories[index].name),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                        category[index].isSelected ? Colors.orange : null),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 250,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: Category.generateCategories[indexCategory]
                    .subCategories.length +
                    1,
                itemBuilder: (context, index) => index <
                    category[indexCategory].subCategories.length
                    ? Container(
                  padding: const EdgeInsets.only(right: 10),
                  width: 150,
                  decoration: BoxDecoration(
                      color: Category.generateCategories[indexCategory]
                          .subCategories[index].color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Category.generateCategories[indexCategory].name} - ${Category.generateCategories[indexCategory].subCategories[index].name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          '${Category.generateCategories[indexCategory].subCategories[index].numberDoctor} Doctors',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        Spacer(),
                        Image.asset(
                          Category.generateCategories[indexCategory]
                              .subCategories[index].imagePath,
                          height: 100,
                          width: 100,
                          alignment: Alignment.bottomLeft,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text('Doctors',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.orangeAccent.withOpacity(.3),
              ),
              height: 60,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.orange.withOpacity(.5),
                    ),
                    child: Image.asset('assets/images/image1.png'),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Dr. Stefeni Albert',
                        style: TextStyle(color: Colors.orange),
                      ),
                      Text(
                        'Heart Speailist',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(width: 130),
                  Container(
                    width: 45,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.orange.withOpacity(.5),
                    ),
                    child: Text(
                      'Call',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  String name;
  List<SubCategory> subCategories;
  bool isSelected;

  Category({this.name, this.subCategories, this.isSelected});

  static List<Category> get generateCategories {
    return List.generate(
      4,
          (index) {
        return Category(
            name: "${nameCategories[index]}",
            subCategories: SubCategory.generateSubCategories,
            isSelected: index == 0 ? true : false);
      },
    );
  }
}

class SubCategory {
  String name;
  int numberDoctor;
  String imagePath;
  Color color;

  SubCategory({this.name, this.numberDoctor, this.imagePath, this.color});

  static List<SubCategory> get generateSubCategories {
    return List.generate(10, (index) {
      int subNameIndex = Random().nextInt(2);
      int numberOfDoctor = Random().nextInt(100) + 1;
      int imageIndex = Random().nextInt(4);
      int bgColorIndex = Random().nextInt(6);
      return SubCategory(
          name: nameSubCategories[subNameIndex],
          numberDoctor: numberOfDoctor,
          imagePath: imageSubCategories[imageIndex],
          color: bgColors[bgColorIndex]);
    });
  }
}

final nameCategories = ["Adults", "Childrens", "Womens", "Mens"];
final nameSubCategories = ["Cough & Cold", "Heart Specialist"];
final List<Color> bgColors = [
  Colors.redAccent,
  Colors.orangeAccent,
  Colors.amber,
  Colors.black,
  Colors.blue,
  Colors.grey,
];

final List<String> imageSubCategories = [
  'assets/images/image1.png',
  'assets/images/image2.png',
  'assets/images/image3.png',
  'assets/images/image4.png',
];