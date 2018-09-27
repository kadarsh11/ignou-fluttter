class QuestionHub {
  String status;
  String semester;
  List<Course> course;

  QuestionHub({this.status, this.semester, this.course});

  QuestionHub.fromJson(Map<String, dynamic> json) {
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
  List<Question> question;

  Course({this.semester, this.code, this.name, this.question});

  Course.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    code = json['code'];
    name = json['name'];
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semester'] = this.semester;
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.question != null) {
      data['question'] = this.question.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String id;
  String pname;
  String pdownload;

  Question({this.id, this.pname, this.pdownload});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pname = json['pname'];
    pdownload = json['pdownload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pname'] = this.pname;
    data['pdownload'] = this.pdownload;
    return data;
  }
}