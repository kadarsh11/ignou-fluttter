import 'dart:async';
import 'dart:io';

import './exception.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class BooksDownload extends StatefulWidget {
  final String course;
  final String id;
  final String title;
  BooksDownload({this.course, this.id, this.title});
  @override
  BooksDownloadState createState() {
    return new BooksDownloadState(course: course, id: id, title: title);
  }
}

class BooksDownloadState extends State<BooksDownload> {
  String course;
  String id;
  String title;
  BooksDownloadState({this.course, this.id, this.title});
  //12R-z5mr2GSzum2bMCRIqwXMcgkeGWRB9

  bool downloading = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    checkDirectory();
  }

  var path;

  Future<void> checkDirectory() async {
    var dir = await getExternalStorageDirectory();
    final myDir = new Directory('${dir.path}/ignou/books');
    myDir.exists().then((isThere) {
      isThere
          ? print("Directory Existed")
          :
          // Creating new Directory
          new Directory('${dir.path}/ignou/books')
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
      await dio.download(imgUrl, "${dir.path}/ignou/books/$course.zip",
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
                          fontWeight: FontWeight.w200),
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
                                        Text("./ignou/books/$course.zip",
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
