class Books {
  String status;
  String semester;
  List<Course> course;

  Books({this.status, this.semester, this.course});

  Books.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    semester = json['semester'];
    if (json['course'] != null) {
      course = new List<Course>();
      json['course'].forEach((v) {
        course.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['semester'] = this.semester;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  String semester;
  String code;
  String name;
  String download;

  Course({this.semester, this.code, this.name, this.download});

  Course.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    code = json['code'];
    name = json['name'];
    download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semester'] = this.semester;
    data['code'] = this.code;
    data['name'] = this.name;
    data['download'] = this.download;
    return data;
  }
}
