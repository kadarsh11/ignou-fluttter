import 'package:flutter/material.dart';
import '../generic/question-gen.dart';
import './questions-download.dart';
import '../generic/ads.dart';

class PaperDetails extends StatefulWidget{
  final List<Question> question;
  final String courseCode;
  final String title;

  PaperDetails({this.question, this.courseCode, this.title});

  @override
  State<StatefulWidget> createState() {
    return PaperDetailsState(question: question,courseCode: courseCode,title: title);
  }

}

class PaperDetailsState extends State<PaperDetails> {
   List<Question> question;
   String courseCode;
   String title;

  PaperDetailsState({this.question, this.courseCode, this.title});

    @override
  void initState() {
    super.initState();
    Ads.showFullScreenAd(this);
  }
       @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(courseCode)),
      body: ListView(
          children: question.map((res) {
        return _listView(res, context);
      }).toList()),
    );
  }

  Widget _listView(var res, BuildContext context) {
    return InkWell(
      onTap: () {
        Ads.hideBannerAd();
        Ads.showFullScreenAd();
        var container = res.pdownload.split("id=");
        String id = container[1];
        print(title);
        print(courseCode);
        print(res.pname);
        print(res.pdownload);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionDownload(
                    course: courseCode, title: title, id: id, pid:res.id)));
      },
      child: Column(children: [
        ListTile(
          leading: _circleText("M", Color(0xFF0984e3)),
          title: Text(res.pname,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(res.pname),
        ),
        Divider(),
      ]),
    );
  }

  //Custom Circular Avatar
  Widget _circleText(String letter, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        letter,
        style: TextStyle(fontSize: 30.0, color: Colors.white),
      ),
    );
  }
}
