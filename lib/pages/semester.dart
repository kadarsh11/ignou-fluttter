import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';
import './generic/books.dart';

class Semester extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SemesterState();
  }
}

class SemesterState extends State<Semester> {
  var url = 'https://api.myjson.com/bins/12n6z0';

  Books books;
  List<Color> gridColor = [
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.redAccent,
    Colors.indigoAccent,
    Colors.black,
    Colors.greenAccent,
    Colors.blueAccent
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    books = Books.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: books == null
            ? Center(child: CircularProgressIndicator())
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
              color: gridColor[2],
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
