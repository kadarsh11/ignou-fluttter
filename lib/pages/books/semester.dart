import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';
import '../generic/books.dart';
import '../generic/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../ui/exception.dart';

class Semester extends StatefulWidget {
  final String course;
  Semester({this.course});

  @override
  State<StatefulWidget> createState() {
    return SemesterState(course: course);
  }
}

class SemesterState extends State<Semester> {
  String course;
  SemesterState({this.course});
  Books books;
  List<Color> gridColor = [
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.redAccent,
    Colors.green,
    Colors.purple,
    Colors.black,
    Colors.indigoAccent,
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
   @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    super.dispose();
  }

  fetchData() async {
    try {
      String url =
          'https://raw.githubusercontent.com/kadarsh11/ignou-fluttter/master/asset/$course.json';
      var res = await http.get(url);
      var decodedJson = jsonDecode(res.body);
      books = Books.fromJson(decodedJson);
      Ads.setBannerAd(size:AdSize.mediumRectangle);
      Ads.showBannerAd(this);
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExceptionUi(error: "No Internet Connection",),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Semester",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: books == null
            ? Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.purple)))
            : GridView.count(
                crossAxisCount: 3,
                children: List.generate(int.tryParse(books.semester),
                    (int index) => _semesterCard(index + 1)).toList()));
  }

  Widget _semesterCard(int sem) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          Ads.hideBannerAd();
          Ads.showFullScreenAd(this);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BooksList(
                        books: books,
                        sem: sem,
                      )));
        },
        child: Container(
            height: 50.0,
            width: 50.0,
            margin: const EdgeInsets.only(left: 10.0, top: 10.0),
            decoration: new BoxDecoration(
              color: gridColor[sem-1],
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                "$sem",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
