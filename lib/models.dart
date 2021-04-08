class Task {
  int id;
  String name;
  bool status;
  double progress;
  String details;
  //having all dates end with Date is cool i think
  DateTime createDate;
  DateTime finishDate;
  DateTime deadlineDate;

  //initilise
  Task({
    this.id,
    this.name,
    this.status,
    this.progress,
    this.details,
    this.createDate,
    this.finishDate,
    this.deadlineDate,
  });

  static Task fromMap(Map<String, dynamic> map) {
    Task task = new Task();
    task.id = map["id"];
    task.name = map["name"];
    task.status = map["status"];
    task.progress = double.parse(map["progress)"]);
    task.details = map["details"];
    task.createDate = DateTime.parse(map["createDate"]);
    task.finishDate = DateTime.parse(map["finishDate"]);
    task.deadlineDate = DateTime.parse(map["deadlineDate"]);
  }

  static List<Task> fromMapList(dynamic mapList) {
    List<Task> list = (mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  //to return as a Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "progress": progress,
      "details": details,
      "createDate": createDate.toString(),
      "finishDate": finishDate.toString(),
      "deadlineDate": deadlineDate.toString(),
    };
  }
}
