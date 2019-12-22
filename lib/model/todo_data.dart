class TodoData {

  String id;
  String todoName;
  String todoSub;
  int todoTime;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['todoName'] = todoName;
    map['todoSub'] = todoSub;
    map['todoTime'] = todoTime;
    return map;
  }

  static TodoData fromMap(Map<String, dynamic> map) {
    TodoData todoData = new TodoData();
    todoData.id = map['id'];
    todoData.todoName = map['todoName'];
    todoData.todoSub = map['todoSub'];
    todoData.todoTime = map['todoTime'];
    return todoData;
  }

  static List<TodoData> fromMapList(dynamic mapList) {
    List<TodoData> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
  
}