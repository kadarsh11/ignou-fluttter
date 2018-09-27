import 'package:flutter/material.dart';
import '../generic/question-gen.dart';
import './paper-details.dart';

class QuestionList extends StatelessWidget {
  final QuestionHub questionHub;
  final int sem;
  QuestionList({this.questionHub, this.sem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester $sem")),
      body: ListView(
          children: questionHub.course.map((res) {
        if (sem == int.parse(res.semester)) {
          return _listView(res, context);
        } else {
          return Container();
        }
      }).toList()),
    );
  }

  Widget _listView(var res, BuildContext context) {

    // List<Question> question=res.question;

    return InkWell(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaperDetails(
                        question: res.question,
                        courseCode: res.code,
                      )));
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
