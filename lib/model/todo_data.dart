class TodoData {

  int id;
  String todoName;
  String todoSub;

  int todoState; //是否完成：1完成  0未完成
  int todoType; //是否是每天任务: 1每日任务  0普通任务

  int todoTime;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['todoName'] = todoName;
    map['todoSub'] = todoSub;
    map['todoTime'] = todoTime;
    map['todoState'] = todoState;
    map['todoType'] = todoType;
    return map;
  }

  static TodoData fromMap(Map<String, dynamic> map) {
    TodoData todoData = new TodoData();
    todoData.id = map['id'];
    todoData.todoName = map['todoName'];
    todoData.todoSub = map['todoSub'];
    todoData.todoTime = map['todoTime'];
    todoData.todoState = map['todoState'];
    todoData.todoType = map['todoType'];
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