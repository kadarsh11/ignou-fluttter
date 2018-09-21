import 'package:flutter/material.dart';

class Grade extends StatefulWidget{

  final String course;
  Grade({this.course});

  @override
  State<StatefulWidget> createState() {
    return GradeState(course);
  }

}

class GradeState extends State<Grade>{

  String course;

  GradeState(this.course);

    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Scaffold(
        appBar: AppBar(
          title: Text(course,style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Your Enrollment Number';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to show a Snackbar
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
      ),
        ),
    );
  }

}