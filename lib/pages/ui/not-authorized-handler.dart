import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import '../home.dart';

class NotAuthorized extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotAuthorizedState();
  }
}

class NotAuthorizedState extends State<NotAuthorized> {

  bool status;

  @override
  void initState() {
    super.initState();
  }

  requestPermission() async {
  final res = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "No Access",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('asset/something_went_wrong_1.png'),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
          child:Text("Storage permission is needed to access books and question paper.",style: TextStyle(fontSize: 23.0),)),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15.0),
          child:FlatButton(
          onPressed: () {requestPermission();}, 
          child: Text("Storage Access",style: TextStyle(color: Colors.white),),
          color: Colors.green,
          ))
        ],
      ),
    );
  }
}
