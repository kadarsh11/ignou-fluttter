import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import './ui/result-card.dart';

class Result extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ResultState();
  }
}

class ResultState extends State<Result>{

  List data=[];
  bool isLoading=true;

  @override
  void initState() {
  super.initState();
  fetchData();
  }

  fetchData() async{
    var result= await http.get("http://www.myroomad.com/ignou/latest.php?program=BCA&eno=166441451&submit=submit");
   
    var jsonBody=jsonDecode(result.body);
    int i=0;
    for(i=2;i<jsonBody.length-1;i++){
      data.add(jsonBody[i]);
    }
    print(data);
    setState(() {isLoading=false;});
  }

  @override
  Widget build(BuildContext context) {
   return  isLoading==true?
   Scaffold(
        body: Center(
       child:CircularProgressIndicator()
     ),
   ):Scaffold(
     body: ListView(
       children: data.map(
         (res){
           return(ResultCard(
             course: res[0],
             assignment: res[1].toString(),
             lab1: res[2].toString(),
             lab2: res[3].toString(),
             lab3: res[4].toString(),
             lab4: res[5].toString(),
             theory: res[6].toString(),
             status: res[7].toString(),
             tPractical:res[8].toString(),
             tTheory: res[9].toString(),
           ));
           }
         ).toList()
     ),
   );
  }
}

class GenericIgnou{
  String course;
  String assignment;
  String lab1;
  String lab2;
  String lab3;
  String lab4;
  String theory;
  String tPractical;
  String tTheory;
  String total;
  GenericIgnou.fromJson({this.course,this.assignment,this.lab1,this.lab2,this.lab3,this.lab4,this.theory,this.total,this.tPractical,this.tTheory});
}