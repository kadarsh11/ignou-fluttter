import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import './ui/result-card.dart';

class Result extends StatefulWidget {
  final String course;
  final String enrollmentNo;

  Result({this.course, this.enrollmentNo});

  @override
  State<StatefulWidget> createState() {
    return ResultState(course: course, enrollmentNo: enrollmentNo);
  }
}

class ResultState extends State<Result> with SingleTickerProviderStateMixin {
  final String course;
  final String enrollmentNo;
  ResultState({this.course, this.enrollmentNo});
  String name;
  TabController tabController;
  List data = [];
  bool isLoading = true;
  bool isError = false;
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  fetchData() async {
    String url =
        'https://www.myroomad.com/ignou/latest.php?program=$course&eno=$enrollmentNo&submit=submit';
    try {
      var result = await http.get(url);
      var jsonBody = jsonDecode(result.body);
      int i = 0;
      int last = jsonBody.length;
      for (i = 2; i < jsonBody.length - 1; i++) {
        data.add(jsonBody[i]);
      }
      Map<String, dynamic> details = jsonBody[0];
      print(details);
      String nameExtract = details['0'];
      var nameSplit = nameExtract.split(':');
      name = nameSplit[1];
      print(jsonBody[last - 1][0] / ((last - 3) * 100));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? isError == true
            ? Scaffold(
                body: Center(
                child: Text("Something Went Wrong"),
              ))
            : Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ))
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.deepPurpleAccent,
                  size: 32.0,
                ),
                title: Text(
                  name,
                  style: TextStyle(color: Colors.deepPurpleAccent),
                )),
            body: TabBarView(controller: tabController, children: [
              ListView(
                  children: <Widget>[
                stats(),
              ]..addAll(_completedList())),
              ListView(
                  children: [
                Text("ALl"),
              ]..addAll(_allList())),
              ListView(
                  children: [
                Text("NOtCompleted"),
              ]..addAll(_notCompletedList())),
            ]),
            bottomNavigationBar: new Material(
              child: new TabBar(
                controller: tabController,
                tabs: <Widget>[
                  new Tab(
                    child: Center(
                      child: Text(
                        "PASS",
                        style: TextStyle(color: Colors.green, fontSize: 21.0),
                      ),
                    ),
                  ),
                  new Tab(
                    child: Center(
                      child: Text(
                        "ALL",
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 21.0),
                      ),
                    ),
                  ),
                  new Tab(
                    child: Center(
                      child: Text(
                        "FAIL",
                        style: TextStyle(color: Colors.red, fontSize: 21.0),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  _completedList() {
    return data.map((res) {
      if (res[7].toLowerCase() == "completed") {
        return (ResultCard(
          course: res[0],
          assignment: res[1].toString(),
          lab1: res[2].toString(),
          lab2: res[3].toString(),
          lab3: res[4].toString(),
          lab4: res[5].toString(),
          theory: res[6].toString(),
          status: res[7].toString(),
          tPractical: res[8].toString(),
          tTheory: res[9].toString(),
        ));
      } else {
        return Container();
      }
    }).toList();
  }

  _notCompletedList() {
    return data.map((res) {
      if (res[7].toLowerCase() == "not completed") {
        return (ResultCard(
          course: res[0],
          assignment: res[1].toString(),
          lab1: res[2].toString(),
          lab2: res[3].toString(),
          lab3: res[4].toString(),
          lab4: res[5].toString(),
          theory: res[6].toString(),
          status: res[7].toString(),
          tPractical: res[8].toString(),
          tTheory: res[9].toString(),
        ));
      } else {
        return Container();
      }
    }).toList();
  }

  _allList() {
    return data.map((res) {
      return (ResultCard(
        course: res[0],
        assignment: res[1].toString(),
        lab1: res[2].toString(),
        lab2: res[3].toString(),
        lab3: res[4].toString(),
        lab4: res[5].toString(),
        theory: res[6].toString(),
        status: res[7].toString(),
        tPractical: res[8].toString(),
        tTheory: res[9].toString(),
      ));
    }).toList();
  }

  Widget stats() {
    return Container(
        height: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
        decoration: new BoxDecoration(
          color: Colors.purpleAccent,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 70.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "98",style: TextStyle(color: Colors.white,fontSize: 28.0)),
                        TextSpan(text: " %",style: TextStyle(color: Colors.white,fontSize: 20.0)),
                      ])),
                      Text("Percentage",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                width: 1.5,
                color: Colors.white30,
              ),
            Container(
                height: 70.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "2",style: TextStyle(color: Colors.white,fontSize: 28.0)),
                        TextSpan(text: "9",style: TextStyle(color: Colors.white,fontSize: 28.0)),
                      ])),
                      Text("Total ",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
              height: 1.5,
              width: 250.0,
              color: Colors.white30,
            ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           Container(
                height: 70.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "15",style: TextStyle(color: Colors.white,fontSize: 28.0)),
                      ])),
                      Text("Completed ",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            Container(
              height: 50.0,
              width: 1.0,
              color: Colors.transparent,
            ),
            Container(
                height: 70.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "7",style: TextStyle(color: Colors.white,fontSize: 28.0)),
                      ])),
                      Text("Not Completed ",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
          ],
        ),
          ]
        ),
        );
  }
}
