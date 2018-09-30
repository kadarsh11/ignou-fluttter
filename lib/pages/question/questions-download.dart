import 'dart:async';
import 'dart:io';

import '../ui/exception.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../generic/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';

class QuestionDownload extends StatefulWidget {
  final String course;
  final String id;
  final String pid;
  final String title;
  QuestionDownload({this.course, this.id, this.title,this.pid});
  @override
  QuestionDownloadState createState() {
    return new QuestionDownloadState(course: course, id: id, title: title,pid: pid);
  }
}

class QuestionDownloadState extends State<QuestionDownload> {
  String course;
  String id;
  String pid;
  String title;
  QuestionDownloadState({this.course, this.id, this.title,this.pid});
  //12R-z5mr2GSzum2bMCRIqwXMcgkeGWRB9

  bool downloading = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    Ads.setBannerAd(size:AdSize.mediumRectangle);
    Ads.showBannerAd(this);
    checkDirectory();
  }
  
 @override
  void dispose() {
    Ads.hideBannerAd();
    Ads.dispose();
    super.dispose();
  }

  var path;

  Future<void> checkDirectory() async {
    var dir = await getExternalStorageDirectory();
    final myDir = new Directory('${dir.path}/ignou/questions');
    myDir.exists().then((isThere) {
      isThere
          ? print("Directory Existed")
          :
          // Creating new Directory
          new Directory('${dir.path}/ignou/questions')
              .create(recursive: true)
              .then((Directory directory) {
              print(directory.path);
              print("Not existed but created");
            });
    });
  }

  Future<void> downloadFile() async {
    setState(() {
          downloading = true;
        });
    final imgUrl =
        "https://drive.google.com/uc?authuser=0&id=$id&export=download";
    Dio dio = Dio();
    var dir = await getExternalStorageDirectory();
    try {
      await dio.download(imgUrl, "${dir.path}/ignou/questions/${course}_p$pid.pdf",
          onProgress: (rec, total) {
        setState(() {
          downloading = true;
        });
      });
      setState(() {
        completed = true;
      });
    } catch (e) {
      print(e);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExceptionUi(),
          ));
    }
    setState(() {
      downloading = false;
    });
    print("Download completed");
    print('${dir.path}');
  }

  @override
  Widget build(BuildContext context) {
    if (completed) {
      Ads.hideBannerAd();
      Ads.showFullScreenAd(this);
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Download",
            style: TextStyle(color: Colors.deepPurple),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            downloading
                ? Center(
                    child: Container(
                      height: 120.0,
                      width: 200.0,
                      child: Card(
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Downloading File:",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      course,
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                     Text(
                        title,
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w300),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Paper-$pid",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            completed
                                ? Image.asset('asset/hurray.jpg')
                                : Container(),
                            completed
                                ? Text(
                                    "Thank You for Downloading",
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20.0,
                                    ),
                                  )
                                : Container(),
                            completed
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    color: Colors.grey[100],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          "You file is saved at",
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("./ignou/questions/${course}_p$pid.pdf",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )
                                : FlatButton(
                                    color: Colors.green,
                                    child: Text(
                                      "Download",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 21.0),
                                    ),
                                    onPressed: () {
                                      Ads.hideBannerAd();
                                      downloadFile();
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                  ]),
          ],
        ));
  }
}
