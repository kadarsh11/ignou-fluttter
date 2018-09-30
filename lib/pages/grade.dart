import 'package:flutter/material.dart';
import './result.dart';
import './generic/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Grade extends StatefulWidget {
  final String course;
  Grade({this.course});

  @override
  State<StatefulWidget> createState() {
    return GradeState(course);
  }
}

class GradeState extends State<Grade> {
  String course;
  GradeState(this.course);

  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

    @override
  void initState() {
    super.initState();
     Ads.setBannerAd(size:AdSize.mediumRectangle);
     Ads.showBannerAd(this);
  }

  @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.deepPurpleAccent,
                  size: 32.0,
                ),
                title: Text(
                  "Enrollment Number",
                  style: TextStyle(color: Colors.deepPurpleAccent),
                )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      new InputDecoration(labelText: "Enter your Enrollment"),
                  keyboardType: TextInputType.number,
                  controller: myController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Your Enrollment No';
                    }
                    if(value.length != 9){
                      return 'Check Your Enrollment No again';
                    }
                  },
                ),
                Container(height: 20.0,),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 12.0),
                    color: Colors.deepPurpleAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Ads.hideBannerAd();
                        Ads.showFullScreenAd(this);
                        print(myController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Result(
                                    course: "BCA",
                                    enrollmentNo: myController.text)));
                      }
                    },
                    child: Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
