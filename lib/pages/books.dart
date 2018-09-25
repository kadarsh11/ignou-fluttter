import 'package:flutter/material.dart';
import './generic/books.dart';

import './ui/books-download.dart';

class BooksList extends StatelessWidget {
  final Books books;
  final int sem;
  BooksList({this.books, this.sem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester $sem")),
      body: ListView(
          children: books.course.map((res) {
        if (sem == int.parse(res.semester)) {
          return _listView(res, context);
        } else {
          return Container();
        }
      }).toList()),
    );
  }

  Widget _listView(var res, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BooksDownload()));
      },
      child: Column(children: [
        ListTile(
          leading: _circleText("M", Color(0xFF0984e3)),
          title:
              Text(res.code, style: new TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(res.name),
        ),
        Divider(),
      ]),
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
