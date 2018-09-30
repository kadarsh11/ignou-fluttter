import 'package:flutter/material.dart';

class ExceptionUi extends StatelessWidget{

  final String error;
  ExceptionUi({this.error});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text("Error Fix It",style: TextStyle(color:Colors.red),),centerTitle: true,backgroundColor: Colors.white),
      body: ListView(
        children:[
          Image.asset("asset/something_went_wrong_1.png"),
          Image.asset("asset/something_went_wrong.png"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(error,style: TextStyle(color: Colors.red,fontSize: 28.0),),),
          )
        ]
      )
    );
  }

}