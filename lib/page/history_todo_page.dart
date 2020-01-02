import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/util/common_util.dart';
import 'package:flutter/material.dart';

class HistoryTodoPage extends StatefulWidget {
  static const routeName = '/page/historyTodo';

  @override
  State<StatefulWidget> createState() {
    return _HistoryTodoPageState();
  }
}

class _HistoryTodoPageState extends State<HistoryTodoPage> {
  List<TodoData> _todoList = new List();
  var db = DatabaseHelper();

  bool isInited = false;

  @override
  void initState() {
    super.initState();
    _getDataFromDb();
  }

  Future<void> _getDataFromDb() async {
    List dbList = await db.getTotalList();
    if (dbList.length > 0) {
      _todoList.clear();
      dbList.forEach((todoData) {
        TodoData itemData = TodoData.fromMap(todoData);
        _operateTodoList(itemData);
      });
    }

    setState(() {
      isInited = true;
    });
  }

  /**
   * 过滤每日任务、已完成任务
   */
  void _operateTodoList(TodoData itemData) {
    if (CommonUtil.isToday(itemData.todoTime)) {
      if (itemData.todoState == 1) {
        //今天的已完成
        _todoList.add(itemData);
      }
    } else {
      _todoList.add(itemData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).drawerItemHistory),
      ),
      body: isInited
          ? _getInitedWidget()
          : Center(
              child: SizedBox(
                height: 100.0,
                width: 100.0,
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget _getInitedWidget() {
    return _todoList.length > 0
        ? ListView.separated(
            itemCount: _todoList.length,
            separatorBuilder: (BuildContext context, int index) =>
                index % 2 == 0
                    ? Divider(color: Colors.green)
                    : Divider(color: Colors.red),
            itemBuilder: (BuildContext context, int index) {
              return _createTodoItem(_todoList[index], index);
            })
        : Center(
            child: Text(
              TodoLocalizations.of(context).emptyTxt,
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          );
  }

  Widget _createTodoItem(TodoData todoData, int postion) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.0,
        ),
        Text(
          todoData.todoState == 1
              ? TodoLocalizations.of(context).done
              : TodoLocalizations.of(context).unDone,
          style: TextStyle(
              color: todoData.todoState == 1 ? Colors.green : Colors.red,
              fontSize: 20.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              todoData.todoType == 1
                  ? '(${TodoLocalizations.of(context).everyTask})${todoData.todoName}'
                  : todoData.todoName,
              style: TextStyle(
                  color: todoData.todoState == 1 ? Colors.green : Colors.red,
                  fontSize: 18.0),
              maxLines: 1,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              todoData.todoSub,
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
              maxLines: 1,
            )
          ],
        )
      ],
    );
  }
}
