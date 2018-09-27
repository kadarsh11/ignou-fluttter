import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class QuestionDownload extends StatefulWidget {
  @override
  QuestionDownloadState createState() {
    return new QuestionDownloadState();
  }
}

class QuestionDownloadState extends State<QuestionDownload> {
  final imgUrl =
      "https://drive.google.com/uc?authuser=0&id=12R-z5mr2GSzum2bMCRIqwXMcgkeGWRB9&export=download";
  bool downloading = false;

  @override
  void initState() {
    super.initState();

    downloadFile();
  }

  var path;

  Future<void> downloadFile() async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    try {
      await dio.download(imgUrl, "${dir.path}/ignou.zip",
          onProgress: (rec, total) {
        print(dir.path);
        setState(() {
          downloading = true;
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
    });
    print("Download completed");
    print('${dir.path}');
    path = '${dir.path}/ignou.zip';
  }

  Future<String> openFile(filePath) async {
    return await OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Center(
        child: downloading
            ? Container(
                height: 120.0,
                width: 200.0,
                child: Card(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
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
              )
            : FlatButton(
                child: Text("Open It"),
                onPressed: () => openFile(path),
              ),
      ),
    );
  }
}
