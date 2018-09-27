import 'package:flutter/material.dart';
import './result.dart';

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
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      new InputDecoration(labelText: "Enter your number"),
                  keyboardType: TextInputType.number,
                  controller: myController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Your Enrollment No';
                    }
                  },
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
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
