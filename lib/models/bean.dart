class NotiBean {
  String userName;
  String content;
  String taskName;
  String date;

  NotiBean(this.userName, this.content, this.taskName, this.date);
}

class TaskBean {
  String taskName;
  String status;
  String time;

  TaskBean(this.taskName, this.status, this.time);
}

class Task {}

class User {
  int id;
  String acco;
  String name;
  String dept;
  String position;

  User({this.acco, this.dept, this.id, this.name, this.position});

  User.fromJson(Map<String, dynamic> user) {
 //   Map<String, dynamic> user = json['list'];
    id = user['id'];
    acco = user['acco'];
    name = user['name'];
    dept = user['dept'];
    position = user['position'];
  }
}
