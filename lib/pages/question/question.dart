import 'package:flutter/material.dart';
import '../generic/question-gen.dart';
import './paper-details.dart';
import 'package:simple_permissions/simple_permissions.dart';
import '../ui/not-authorized-handler.dart';
import '../generic/ads.dart';

class QuestionList extends StatefulWidget {
  final QuestionHub questionHub;
  final int sem;
  QuestionList({this.questionHub, this.sem});
  @override
  State<StatefulWidget> createState() {
    return QuestionListState(questionHub: questionHub, sem: sem);
  }
}

class QuestionListState extends State<QuestionList> {
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    super.dispose();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
        
    print("permission is " + res.toString());
    if (res == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotAuthorized(),
          ));
     Ads.showBannerAd(this);           
    }
  }

  final QuestionHub questionHub;
  final int sem;
  QuestionListState({this.questionHub, this.sem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester $sem")),
      body: ListView(
          children: questionHub.course.map((res) {
        if (sem == int.parse(res.semester)) {
          return _listView(res, context);
        } else {
          return Container();
        }
      }).toList()),
    );
  }

  Widget _listView(var res, BuildContext context) {
    // List<Question> question=res.question;

    return InkWell(
      onTap: () {
        Ads.hideBannerAd();
        Ads.showFullScreenAd(this);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaperDetails(
                      question: res.question,
                      courseCode: res.code,
                      title: res.name,
                    )));
      },
      child: Column(children: [
        ListTile(
          leading: _circleText("M", Color(0xFF0984e3)),
          title:
              Text(res.code, style: new TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(res.name),
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
