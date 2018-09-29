import 'package:flutter/material.dart';
import 'dart:convert';
import '../generic/question-gen.dart';
import 'package:http/http.dart' as http;
import 'question.dart';
import '../ui/exception.dart';

class QuestionSemester extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SemesterState();
  }
}

class SemesterState extends State<QuestionSemester> {
  var url = 'https://raw.githubusercontent.com/kadarsh11/ignou-fluttter/master/asset/bca_paper.json';

  QuestionHub questionHub;
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
    try {
      var res = await http.get(url);
      var decodedJson = jsonDecode(res.body);
      questionHub = QuestionHub.fromJson(decodedJson);
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExceptionUi(),
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
        body: questionHub == null
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 3,
                children: List.generate(int.tryParse(questionHub.semester),
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
                  builder: (context) => QuestionList(
                        questionHub: questionHub,
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
