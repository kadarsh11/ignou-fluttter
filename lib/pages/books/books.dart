import 'package:flutter/material.dart';
import '../generic/books.dart';
import 'package:simple_permissions/simple_permissions.dart';
import '../ui/books-download.dart';
import '../ui/not-authorized-handler.dart';

class BooksList extends StatefulWidget{
  final Books books;
  final int sem;
  BooksList({this.books, this.sem});

  @override
  State<StatefulWidget> createState() {
    return BooksListState(books:books,sem:sem);
  }
}

class BooksListState extends State<BooksList> {
  final Books books;
  final int sem;
  BooksListState({this.books, this.sem});

    @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    print("permission is " + res.toString());
    if(res==false){
     Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotAuthorized(),
                ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester $sem")),
      body: ListView(
          children: books.course.map((res) {
        if (sem == int.parse(res.semester)) {
          return _listView(res, context);
        } else {
          return Container();
        }
      }).toList()),
    );
  }

  Widget _listView(var res, BuildContext context) {
    return InkWell(
      onTap: () {
        var container=res.download.split("id=");
        String id=container[1];
        print(res.download);
        print(id);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BooksDownload(course: res.code,title: res.name,id: id,)));
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
