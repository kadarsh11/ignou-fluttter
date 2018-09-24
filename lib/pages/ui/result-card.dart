import 'dart:math';

import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget{

   final String course;
   final String assignment;
   final String lab1;
   final String lab2;
   final String lab3;
   final String lab4;
   final String theory;
   final String tPractical;
   final String tTheory;
   final String status;

  ResultCard({this.course,this.assignment,this.lab1,this.lab2,this.lab3,this.lab4,this.theory,this.tTheory,this.tPractical,this.status});

    @override
  Widget build(BuildContext context) {

      final planetThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        child: _circleText(),
      )
    );    

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 50.0, right: 0.0),
      decoration: new BoxDecoration(
        color: status.toLowerCase()=="completed"? Colors.greenAccent : Colors.redAccent,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 50.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: new Text(course,style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
            ),
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              (assignment=="-" || assignment=="") ? Container() : _circleMarks("Asgn.",assignment,Colors.deepOrangeAccent),
              (lab1=="-" || lab1=="") ? Container() : _circleMarks("Lab 1",lab1,Colors.deepOrangeAccent),
              (lab2=="-" || lab2=="") ? Container() : _circleMarks("Lab 1",lab2,Colors.deepOrangeAccent),
              (lab3=="-" || lab3=="") ? Container() : _circleMarks("Lab 1",lab3,Colors.deepOrangeAccent),
              (lab4=="-" || lab4=="") ? Container() : _circleMarks("Lab 1",lab4,Colors.deepOrangeAccent),
              (theory=="-" || theory=="") ? Container() : _circleMarks("Theory",theory,Colors.deepOrangeAccent),
              ],
            ),
          ],
        ),
      ),
    );

    return 
    Container(
      height: 160.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => "Hola",

        child: Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail
          ],
        ),
      ),
    );
  }

    Widget _circleText(){
    return CircleAvatar(
      backgroundColor: status.toLowerCase()=="completed"? Colors.green : Colors.red,
      child: status.toLowerCase()=="completed"?Icon(Icons.done_all,color: Colors.white,size:53.0) :
                                               Icon(Icons.clear,color: Colors.white,size:53.0)                
      );
  }
 
  Widget _circleMarks( final String type, final String marks,Color color){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Container(
          height: 40.0,
          width: 40.0,
          child: new CustomPaint(
            foregroundPainter: new MyPainter(
                lineColor: Colors.white,
                completeColor: color,
                completePercent: double.parse(marks),
                width: 3.0
            ),
            child: new Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(marks,style: TextStyle(color: color,fontSize: 14.0,fontWeight: FontWeight.bold),),
              )
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top:1.5),),
        Text(type,style: TextStyle(color: color,fontSize: 11.0,fontWeight: FontWeight.bold),)
        ]
    );
  }
}
class MyPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  MyPainter({this.lineColor,this.completeColor,this.completePercent,this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
        ..color = lineColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center  = new Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);
    canvas.drawCircle(
        center,
        radius,
        line
    );
    double arcAngle = 2*pi* (completePercent/100);
    canvas.drawArc(
        new Rect.fromCircle(center: center,radius: radius),
        -pi/2,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}