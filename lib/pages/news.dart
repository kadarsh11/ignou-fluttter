import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './ui/exception.dart';

class News extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
}

class NewsState extends State<News> with SingleTickerProviderStateMixin {
  String urlIgnou =
      "https://newsapi.org/v2/everything?q=ignou&sortBy=popularity&apiKey=6368e6c64862409b8a2bfd5f9e6b0477";

  String urlJob =
      "https://newsapi.org/v2/everything?q=job&sortBy=popularity&apiKey=6368e6c64862409b8a2bfd5f9e6b0477";

  Newshub newshubIgnou;
  Newshub newshubJob;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    fetchDataIgnou();
    fetchDataJob();
    tabController = new TabController(length: 2, vsync: this);
  }

  fetchDataIgnou() async {
    try {
      var res = await http.get(urlIgnou);
      var decodedJson = jsonDecode(res.body);
      newshubIgnou = Newshub.fromJson(decodedJson);
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExceptionUi(),
          ));
    }
  }

  fetchDataJob() async {
    try {
      var res = await http.get(urlJob);
      var decodedJson = jsonDecode(res.body);
      newshubJob = Newshub.fromJson(decodedJson);
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExceptionUi(error: "No Internet Connection"),
          ));
    }
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (newshubIgnou == null || newshubJob == null)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "News",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: newshubIgnou == null || newshubJob == null
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: newshubIgnou == null
                            ? 0
                            : newshubIgnou.articles.length,
                        padding: new EdgeInsets.all(8.0),
                        itemBuilder: (BuildContext context, int index) {
                          return _newsIgnouLayout(index, context);
                        },
                      ),
                      ListView.builder(
                        itemCount:
                            newshubJob == null ? 0 : newshubJob.articles.length,
                        padding: new EdgeInsets.all(8.0),
                        itemBuilder: (BuildContext context, int index) {
                          return _newsJobLayout(index, context);
                        },
                      ),
                    ],
                  ),
            bottomNavigationBar: new Material(
              child: new TabBar(
                controller: tabController,
                tabs: <Widget>[
                  new Tab(
                    child: Center(
                      child: Text(
                        "Ignou",
                        style: TextStyle(color: Colors.green, fontSize: 21.0),
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        "Job",
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 21.0),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _newsIgnouLayout(int index, BuildContext context) {
    return Card(
      elevation: 1.7,
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: [
            new Row(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(left: 4.0),
                  child: new Text(
                    newshubIgnou.articles[index].publishedAt,
                    style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(
                    newshubIgnou.articles[index].source.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new GestureDetector(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                          child: new Text(newshubIgnou.articles[index].title,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 4.0, bottom: 4.0),
                          child:
                              new Text(newshubIgnou.articles[index].description,
                                  style: new TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                  maxLines: 4),
                        ),
                      ],
                    ),
                    onTap: () {
                      print(newshubIgnou.articles[index].urlToImage);
                    },
                  ),
                ),
                new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top: 8.0),
                      child: new SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: newshubIgnou.articles[index].urlToImage==null
                                ? Image.asset(
                                    'asset/something_went_wrong_1.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    newshubIgnou.articles[index].urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _newsJobLayout(int index, BuildContext context) {
    return Card(
      elevation: 1.7,
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: [
            new Row(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(left: 4.0),
                  child: new Text(
                    newshubJob.articles[index].publishedAt,
                    style: new TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Text(
                    newshubJob.articles[index].source.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: [
                new Expanded(
                  child: new GestureDetector(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                          child: new Text(newshubJob.articles[index].title,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                              left: 4.0, right: 4.0, bottom: 4.0),
                          child:
                              new Text(newshubJob.articles[index].description,
                                  style: new TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                  maxLines: 4),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("Hols");
                    },
                  ),
                ),
                new Column(
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.only(top: 8.0),
                        child: new SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: newshubJob.articles[index].urlToImage.isEmpty
                                ? Image.asset(
                                    'asset/something_went_wrong_1.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    newshubJob.articles[index].urlToImage,
                                    fit: BoxFit.cover,
                                  )))
                  ],
                )
              ],
            )
          ],
        ), ////
      ),
    );
  }
}

class Newshub {
  String status;
  int totalResults;
  List<Articles> articles;

  Newshub({this.status, this.totalResults, this.articles});

  Newshub.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
