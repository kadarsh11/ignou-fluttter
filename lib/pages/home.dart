import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import './news.dart';
import './books/semester.dart';
import './question/semester.dart';
import './grade.dart';
import './generic/ads.dart';

const String testDevice = "6B3275A219CC14AB01E774687EC3F4B2";

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<Home> {

  @override
  void initState() {
    super.initState();
    Ads.init('---------- PUBLISHER ADD IP ---------------',
        keywords: <String>[
          'education',
          'books',
          'result',
          'news',
          'University',
          'Open University',
          'informative',
          'ignou study material',
          'entertainment',
          'informative',
          'creativity',
          'ignou question paper',
          'study',
          'question paper',
          'ignou official',
          'fun',
          'tutorial',
          'ignou grade card',
          'ignou result',
          'Indira gandhi open university',
          'News ignou',
          'ignou books',
        ],
        birthday: DateTime.now(),
        testDevices: testDevice != null ? <String>[testDevice] : null,
        testing: false,
        );
        
    checkPermission();
    insertData();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    print("permission is " + res.toString());
    if (res == false) {
      final res = await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      print("permission request result is " + res.toString());
    }
  }

  @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    super.dispose();
  }

  List<String> features = ["BOOKS", "QUESTION PAPER", "GRADE CARD", "NEWS"];
  List<Color> startColor = [
    Color(0xAA21D4FD),
    Color(0xFF08AEEA),
    Color(0xFFFEE140),
    Color(0xFFFBDA61)
  ];
  List<Color> endColor = [
    Color(0xAAB721FF),
    Color(0xFF2AF598),
    Color(0xFFFA709A),
    Color(0xFFFF5ACD)
  ];
  List<DetailsType> type = [];

//Pop UP menu for Books
  void _showModalSheetBooks() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 1.9,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text("BOOKS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF662E9B))),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  ListTile(
                    leading: _circleText("B", Color(0xFFFF0022)),
                    title: Text("BCA",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Bachelor of Computer Application"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Semester(
                                    course: "bca",
                                  )));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: _circleText("M", Color(0xFF0984e3)),
                    title: Text("MCA",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Master of Computer Application"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Semester(
                                    course: "mca",
                                  )));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: _circleText("C", Color(0xFF27ae60)),
                    title: Text("B.Com",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Bachelor of Commerce"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Semester(
                                    course: "bcom",
                                  )));
                    },
                  ),
                  Divider()
                ],
              ),
            ),
          );
        });
  }

//Pop Up menu for Question Paper
  void _showModalSheetQuestion() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 1.9,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text("Question Paper",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF662E9B))),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  ListTile(
                    leading: _circleText("B", Color(0xFFFF0022)),
                    title: Text("BCA",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Bachelor of Computer Application"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionSemester()));
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }

//Pop Up menu for Grade
  void _showModalSheetGrade() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 1.9,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text("Grade Card",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF662E9B))),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  ListTile(
                    leading: _circleText("B", Color(0xFFFF0022)),
                    title: Text("BCA",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Bachelor of Computer Application"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Grade(
                                    course: "BCA",
                                  )));
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }

//Laying Out Feature Gradient Color
  void insertData() {
    int i = 0;
    for (i = 0; i < features.length; i++) {
      DetailsType t = new DetailsType(
          feature: features[i],
          startGradient: startColor[i],
          endGradient: endColor[i]);
      type.add(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("IGNOU",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16.0,
                      )),
                  background: Image.asset(
                    "asset/hero.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: Center(
            child: GridView.count(
                crossAxisCount: 2,
                children: type.map((types) => boxes(types, context)).toList()),
          ),
        ),
      ),
    );
  }

  Widget boxes(DetailsType type, BuildContext context) {
    Color gradientStart = type.startGradient; //Change start gradient color here
    Color gradientEnd = type.endGradient;
    return InkWell(
      onTap: () {
        Ads.hideBannerAd();
        if (type.feature.toLowerCase() == "books") {
          Ads.showFullScreenAd(this);
          _showModalSheetBooks();
        }
        if (type.feature.toLowerCase() == "news") {
          Ads.showFullScreenAd(this);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => News()));
          print("News");
        }
        if (type.feature.toLowerCase() == "question paper") {
          Ads.showFullScreenAd(this);
          _showModalSheetQuestion();
        }
        if (type.feature.toLowerCase() == "grade card") {
          Ads.showFullScreenAd(this);
          _showModalSheetGrade();
        }
      },
      child: Card(
        child: Container(
          height: 200.0,
          width: 200.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            gradient: new LinearGradient(
                colors: [gradientEnd, gradientStart],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Text(
              type.feature,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

//Custom Circular Avatar
  Widget _circleText(String letter, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        letter,
        style: TextStyle(fontSize: 30.0, color: Colors.white),
      ),
    );
  }
}

//Class for Feature type and Gradient
class DetailsType {
  String feature;
  Color startGradient;
  Color endGradient;
  DetailsType({this.feature, this.startGradient, this.endGradient});
}
