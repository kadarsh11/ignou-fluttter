import 'dart:math';

import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget{

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
        color: Colors.greenAccent,
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
              child: new Text("MCS-012",style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
            ),
            Padding(padding: EdgeInsets.only(top:15.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _circleMarks("Lab 1","55",Colors.deepOrangeAccent),
                _circleMarks("Theory","75",Colors.blueAccent),
                _circleMarks("Theory","75",Colors.purpleAccent),
              ],
            ),
          ],
        ),
      ),
    );

    return new Container(
      height: 150.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () => "Hola",

        child: new Stack(
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
      backgroundColor: Colors.green,
      child: Text("A",
      style: TextStyle(fontSize: 30.0,color: Colors.white),),);
  }

  Widget _circleMarks(String type,String marks,Color color){
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