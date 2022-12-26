import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/store.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'upload.dart';
import 'profile.dart';
import 'notipication.dart';
import 'shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => Store1()),
      ChangeNotifierProvider(create: (c) => Store2()),
    ],
    child: MaterialApp(theme: style.theme, home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data;
  var userImage;
  var userContent;
  var saveDataLog;

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    setState(() {
      data = jsonDecode(result.body);
    });
    saveData();
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addData() {
    var userData = {
      'id': data.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John kin'
    };
    setState(() {
      data.insert(0, userData);
    });
  }

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setString("data", jsonEncode(data));
    saveDataLog = storage.getString("data");
    print(jsonDecode(saveDataLog));
  }

  // saveDataView() async{
  //   var storage = await SharedPreferences.getInstance();
  //   saveDataLog ?? "null";
  // }
  @override
  void initState() {
    super.initState();
    getData();
    initNotification(context);
    // saveDataView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Instagram",
              style: TextStyle(
                  fontFamily: "nunnu",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  onPressed: () async {
                    var picker = ImagePicker();
                    var image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        userImage = File(image.path);
                      });
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Upload(
                                  userImage: userImage,
                                  setUserContent: setUserContent,
                                  addData: addData,
                                )));
                  },
                  iconSize: 30)
            ]),
        body: [HomeTab(data: data), shop()][tab],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (i) {
              setState(() {
                tab = i;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "홈",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: "샵")
            ]));
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore() async {
          var result = await http
              .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
          setState(() {
            widget.data.add(jsonDecode(result.body));
          });
        }

        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      print(widget.data.isNotEmpty);
      return ListView.builder(
          itemCount: widget.data == null ? 0 : widget.data.length,
          controller: scroll,
          itemBuilder: (c, i) => Container(
            margin: EdgeInsets.only(left: 100,right: 100),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: widget.data[i]["image"].runtimeType == String
                        ? Image.network(widget.data[i]["image"])
                        : Image.file(widget.data[i]["image"]),
                  ),
                  GestureDetector(
                      child: Text(widget.data[i]["user"]),
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (c) => Profile()));
                      }),
                  Text(widget.data[i]["likes"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.data[i]["content"])
                ],
              )));
    } else {
      return Text("로딩중");
    }
  }
}
