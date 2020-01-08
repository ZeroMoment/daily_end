import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/util/common_util.dart';
import 'package:date_format/date_format.dart';
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
    List dbList = await db.getTotalListRevers();
    if (dbList.length > 0) {
      _tempCount = 0;
      _todoList.clear();
      //处理第一个时间分组
      TodoData firstItem = TodoData.fromMap(dbList[0]);
      if (CommonUtil.isToday(firstItem.todoTime)) {
        if (firstItem.todoState == 1) {
          TodoData timeLineData = new TodoData();
          timeLineData.todoTime = firstItem.todoTime;
          timeLineData.istimeLine = true;
          _todoList.add(timeLineData);
        }
      }
      dbList.forEach((todoData) {
        TodoData itemData = TodoData.fromMap(todoData);
        _operateTodoList(itemData);
      });
    }

    setState(() {
      isInited = true;
    });
  }

  int _tempCount = 0;
  bool isDayEquals = false;
  int _tempTimeMill = 0;
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
      if (_tempCount > 0 && _tempTimeMill > 0) {
        isDayEquals = CommonUtil.dayIsEqual(_tempTimeMill, itemData.todoTime);
      }

      if (_tempCount == 0 || !isDayEquals) {
        TodoData timeLineData = new TodoData();
        timeLineData.todoTime = itemData.todoTime;
        timeLineData.istimeLine = true;
        _todoList.add(timeLineData);

        _tempTimeMill = itemData.todoTime;
      }

      _todoList.add(itemData);
      _tempCount++;
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
        ? ListView.builder(
            itemCount: _todoList.length,
            itemBuilder: (BuildContext context, int index) {
              TodoData itemData = _todoList[index];
              if (itemData.istimeLine) {
                return _createTimeline(itemData.todoTime);
              } else {
                return _createTodoItem(itemData);
              }
            })
        : Center(
            child: Text(
              TodoLocalizations.of(context).emptyTxt,
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          );
  }

  //创建时间分级
  Widget _createTimeline(int millTime) {
    DateTime historyTime = DateTime.fromMillisecondsSinceEpoch(millTime);
    String historyTimeLineTxt =
        formatDate(historyTime, [yyyy, '-', mm, '-', dd]);
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      width: MediaQuery.of(context).size.width,
      height: 30.0,
      color: CommonUtil.hexToColor("#ebebeb"),
      alignment: Alignment.centerLeft,
      child: Text(
        historyTimeLineTxt,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //历史记录item
  Widget _createTodoItem(TodoData todoData) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0,),
        Row(
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
              width: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  todoData.todoType == 1
                      ? '(${TodoLocalizations.of(context).everyTask})${todoData.todoName}'
                      : todoData.todoName,
                  style: TextStyle(
                      color: todoData.todoState == 1
                          ? (todoData.todoType == 1 ? Colors.blue : Colors.grey)
                          : Colors.red,
                      fontSize: 18.0),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  todoData.todoSub,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  maxLines: 1,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10.0,),
        Divider(
          color: Colors.green,
          height: 1.0,
        )
      ],
    );
  }
}
