import 'package:flutter/material.dart';

class ExceptionUi extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children:[
          Image.asset("asset/something_went_wrong_1.png"),
          Image.asset("asset/something_went_wrong.png")
        ]
      )
    );
  }

}