class Notifi {
  int id;

  String userName;
  String content;
  String subjectName;
  String date;

  String type;
  int subjectId;

  //Notifi();

  Notifi(
      {this.id,
      this.userName,
      this.content,
      this.subjectName,
      this.date,
      this.type,
      this.subjectId}); //{list: [{id: 153, pid: 19, tid: null, creator: kanye, content: 132132, creatTime: 2019-11-11 23:17:23,
  // subject_id: 19, type: project, subject_name: fish_bone}, {id: 165, pid: 19, tid: null, creator: kanye,
  // content: 13123123, creatTime: 2019-11-11 23:52:48, subject_id: 19, type: project, subject_name: fish_bone},
  // {id: 205, pid: null, tid: 62, creator: kanye, content: 修改任务抄送人为：
  // [{"acco":"Test2","name":"uzi","id":3,"dept":"智能网联","position":"软件开发工程师"}],
  // creatTime: 2019-11-12 19:22:49, subject_id: 62, type: task, subject_name: 任务Test},
  // {id: 206, pid: null, tid: 62, creator: kanye, content: 修改任务抄送人为：
  // [{"acco":"Test2","name":"uzi","id":3,"dept":"智能网联","position":"软件开发工程师"},
  // {"acco":"Test3","name":"offset","id":4,"dept":"智能网联","position":"软件开发工程师"}],
  // creatTime: 2019-11-12 19:22:59, subject_id: 62, type: task, subject_name: 任务Test},
  // {id: 209, pid: null, tid: 62, creator: kanye, content: <…>

  factory Notifi.fromJson(Map<String, dynamic> json) {
    return Notifi()
      ..id = json['id']
      ..userName = json['creator']
      ..content = json['content']
      ..subjectName = json['subject_name']
      ..date = json['creatTime']
      ..type = json['type']
      ..subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'creator': this.userName,
      'content': this.content,
      'subject_name': this.subjectName,
      'creatTime': this.date,
      'type': this.type,
      'subject_id': this.subjectId,
    };
  }
}

class TaskBean {
  String taskName;
  String status;
  String time;

  TaskBean(this.taskName, this.status, this.time);
}

class Task {
  //{id: 64, name: 任务Test, code: T20191027, type: 普通, content: 这是一个任务啊, fGid: 81, cGid: 82,
  // creatDate: 2019-10-18 00:20:32, startDate: 2019-09-27 00:56:41, endDate: 2019-11-02 20:02:20,
  // priority: 普通, finishDate: null, percent: 10%, status: 进行中, version: , itera: , pid: 19,
  // modal: , lastUpdate: 2019-10-21 19:18:35, creator: kanye, isMilestone: 是, ff: [], cc: [],
  // project: {id: 19, name: fish_bone, creator: wukong, pmUid: 2, creatDate: 2019-10-14 01:04:50,
  // startDate: 2019-09-02 08:00:00, endDate: 2019-11-09 08:00:00, priority: 低, partnerGid: 188, cGid: 190,
  // content: postman测试 dsadsgfdsfsd, percent: 38%, type: 瀑布, lastUpdate: 2019-10-16 19:52:12,
  // code: 123, isControl: 是, pm: {id: 2, acco: Test1, name: wukong, dept: 智能网联, position: 软件开发工程师},
  // partner: [{id: 3, acco: Test2, name: uzi, dept: 智能网联, position: 软件开发工程师}],
  // cc: [{id: 1, acco: yunwei001, name: Test2, dept: 智能网联, position: 产品经理},

  int id;
  String name;
  String code;
  String type;
  String content;
  String creatDate;
  String startDate;
  String endDate;
  String finishDate;
  String priority;
  String percent;
  String status;
  String lastUpdate;
  String creator;

  // String isMilestone;
  List<User> ff;
  List<User> cc;
  Project project;

  Task();

  factory Task.fromJson(Map<String, dynamic> json) {
    var ff1 = json['ff'] as List;
    var cc1 = json['cc'] as List;
    return Task()
      ..id = json['id']
      ..name = json['name']
      ..code = json['code']
      ..type = json['code']
      ..content = json['content']
      ..creatDate = json['creatDate']
      ..startDate = json['startDate']
      ..endDate = json['endDate']
      ..finishDate = json['finishDate']
      ..priority = json['priority']
      ..percent = json['percent']
      ..status = json['status']
      ..lastUpdate = json['lastUpdate']
      ..creator = json['creator']
      ..ff = ff1.map((i) => User.fromJson(i)).toList()
      ..cc = cc1.map((i) => User.fromJson(i)).toList()
      ..project =
          (json['project'] != null) ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'type': this.type,
      'content': this.content,
      'creatDate': this.creatDate,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'finishDate': this.finishDate,
      'priority': this.priority,
      'percent': this.percent,
      'status': this.status,
      'lastUpdate': this.lastUpdate,
      'creator': this.creator,
      'project': this.project?.toJson(),
      'ff': this.ff?.map((v) => v.toJson())?.toList(),
      'cc': this.cc?.map((v) => v.toJson())?.toList(),
    };
  }
}

class Project {
  // project: {id: 19, name: fish_bone, creator: wukong, pmUid: 2, creatDate: 2019-10-14 01:04:50,
  // startDate: 2019-09-02 08:00:00, endDate: 2019-11-09 08:00:00, priority: 低, partnerGid: 188, cGid: 190,
  // content: postman测试 dsadsgfdsfsd, percent: 38%, type: 瀑布, lastUpdate: 2019-10-16 19:52:12,
  // code: 123, isControl: 是, pm: {id: 2, acco: Test1, name: wukong, dept: 智能网联, position: 软件开发工程师},
  // partner: [{id: 3, acco: Test2, name: uzi, dept: 智能网联, position: 软件开发工程师}],
  // cc: [{id: 1, acco: yunwei001, name: Test2, dept: 智能网联, position: 产品经理},

  int id;
  String name;
  String creator;
  String creatDate;
  String startDate;
  String endDate;
  String priority;
  String content;
  String percent;
  String type;
  String lastUpdate;
  String code;
  User pm;
  List<User> partner;
  List<User> cc;

  Project();

  factory Project.fromJson(Map<String, dynamic> json) {
    var pp1 = json['partner'] as List;
    var cc1 = json['cc'] as List;
    return Project()
      ..id = json['id']
      ..name = json['name']
      ..code = json['code']
      ..type = json['code']
      ..content = json['content']
      ..creatDate = json['creatDate']
      ..startDate = json['startDate']
      ..endDate = json['endDate']
      ..priority = json['priority']
      ..percent = json['percent']
      ..lastUpdate = json['lastUpdate']
      ..creator = json['creator']
      ..pm = User.fromJson(json['pm'])
      ..partner = pp1.map((i) => User.fromJson(i)).toList()
      ..cc = cc1.map((i) => User.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'type': this.type,
      'content': this.content,
      'creatDate': this.creatDate,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'priority': this.priority,
      'percent': this.percent,
      'lastUpdate': this.lastUpdate,
      'creator': this.creator,
      'pm': this.pm?.toJson(),
      'partner': this.partner?.map((v) => v.toJson())?.toList(),
      'cc': this.cc?.map((v) => v.toJson())?.toList()
    };
  }
}

class User {
  int id;
  String acco;
  String name;
  String dept;
  String position;

  User({this.acco, this.dept, this.id, this.name, this.position});

  factory User.fromJson(Map<String, dynamic> user) {
    return User()
      ..id = user['id']
      ..acco = user['acco']
      ..name = user['name']
      ..dept = user['dept']
      ..position = user['position'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'acco': this.acco,
        'name': this.name,
        'dept': this.dept,
        'position': this.position
      };
}
