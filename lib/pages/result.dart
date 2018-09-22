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

class ResultState extends State<Result> with SingleTickerProviderStateMixin{

  TabController tabController;
  List data=[];
  bool isLoading=true;
  double percentage=0.0;

  @override
  void initState() {
  super.initState();
  fetchData();
  tabController = new TabController(length: 3,vsync: this);
  }

  @override
  void dispose(){
  super.dispose();
  tabController.dispose();
  }

  fetchData() async{
    var result= await http.get("http://www.myroomad.com/ignou/latest.php?program=BCA&eno=166441451&submit=submit");
   
    var jsonBody=jsonDecode(result.body);
    int i=0;
    int last=jsonBody.length;
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
     appBar: AppBar(
       backgroundColor: Colors.white,
       leading: Icon(Icons.sentiment_very_satisfied,color:Colors.deepPurpleAccent,size: 32.0,),
       title: Text("ADARSH KUMAR",style: TextStyle(color: Colors.deepPurpleAccent),),
       actions: <Widget>[
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text("Total",style: TextStyle(color: Colors.indigoAccent,fontWeight: FontWeight.bold)),
             Padding(padding: EdgeInsets.only(top: 1.0),),
             Text("Percentage",style: TextStyle(color: Colors.indigoAccent,fontWeight: FontWeight.bold),),
           ],
         ),
         CircleAvatar(
           backgroundColor: Colors.indigoAccent,
           child: Text("98%",style: TextStyle(color: Colors.white),),
         )
       ],
     ),
     body: TabBarView(
       controller: tabController,
            children : [
          ListView(
            children: data.map(
            (res){
              if(res[7].toLowerCase()=="completed"){
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
              ));}
              
              else{
                return Container();
              }
              }
            ).toList()
       ),
       ListView(
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
       ListView(
            children: data.map(
            (res){
              if(res[7].toLowerCase()=="not completed"){
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
              ));}
              else{
                return Container();
              }
              }
            ).toList()
       ),
       ]
     ),
     bottomNavigationBar:new Material(
      child: new TabBar(
        controller: tabController,
          tabs: <Widget>[
          new Tab(
          child: Center(
            child: Text("PASS",style: TextStyle(color: Colors.green,fontSize: 21.0),),
          ),
          ),
          new Tab(
          child: Center(
            child: Text("ALL",style: TextStyle(color: Colors.deepPurple,fontSize: 21.0),),
          ),
          ),
          new Tab(
          child: Center(
            child: Text("FAIL",style: TextStyle(color: Colors.red,fontSize: 21.0),),
          ),
          ),
        ],
        ),
      )
   );
  }
}