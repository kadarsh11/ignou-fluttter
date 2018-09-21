import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './ui/result-card.dart';

class Result extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ResultState();
  }

}

class ResultState extends State<Result>{

  var data;

  @override
  void initState() {
  super.initState();
  fetchData();
  }

  fetchData() async{
    var result= await http.get("http://www.myroomad.com/ignou/latest.php?program=BCA&eno=166441451&submit=submit");
    data=result;
    print(result);
  }

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body: ListView(
       children: <Widget>[
         ResultCard(),
         ResultCard(),
         ResultCard(),
       ],
     ),
   );
  }

}