import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class News extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return NewsState();
  }
}

class NewsState extends State<News>{

  NewsBuilder newsBuilder;

  @override
  void initState() {
  super.initState();
  getData();
  }

  getData()  async{
    String url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6368e6c64862409b8a2bfd5f9e6b0477";
    var res= await http.get(url);
    var decodedJson= jsonDecode(res.body);
    newsBuilder= NewsBuilder.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newsBuilder==null? Center(
        child: CircularProgressIndicator(),
      ):_buildCard(context),       

       bottomNavigationBar:BottomNavigationBar(
         items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.backup), 
            title: Text("Ignou"),
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.mail), 
            title: Text("Tech"),
            ),
         ],
       )
    );
  }

  Widget _buildCard(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
          children:[
             Row(
               children:[            
              ListTile(
                title: Text("Add-on courses from IGNOU making rural students job-ready",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("Regional Director says fee waiver for SC, ST students also becomes an advantage"),
              ),
          ]),
          Row(
            children: <Widget>[
              Text("2018-09-20T13:00:56Z"),
              FilterChip(
                onSelected: (bool value) {}, 
                backgroundColor: Colors.red,
                label: Text("Indianexpress.com",style: TextStyle(color: Colors.white)),
              )
          ],)
        ]
      ),
    );
  }

}


class NewsBuilder {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsBuilder({this.status, this.totalResults, this.articles});

  NewsBuilder.fromJson(Map<String, dynamic> json) {
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
