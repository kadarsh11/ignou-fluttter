import 'package:flutter/material.dart';
import '../generic/question-gen.dart';

class PaperDetails extends StatelessWidget{

  final List<Question> question;
  final String courseCode;

  PaperDetails({this.question, this.courseCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(courseCode)),
      body: ListView(
          children: question.map((res) {
          return _listView(res, context);
      }).toList()),
    );    
  }

  Widget _listView(var res, BuildContext context) {
    return InkWell(
      onTap: () {
       print(res);
      },
      child: Column(children: [
        ListTile(
          leading: _circleText("M", Color(0xFF0984e3)),
          title:
              Text(res.pname, style: new TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(res.pname),
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