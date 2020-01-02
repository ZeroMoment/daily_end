import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/localization/todo_localizations_delegate.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/page/ad_banner_page.dart';
import 'package:daily_end/page/edit_todo_page.dart';
import 'package:daily_end/util/common_util.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';

import 'widget/ya_custom_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1984117899270114~3221984939");

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        TodoLocalizationsDelegate()
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('zh', 'CN')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          EditTodoPage.routeName: (ctx) => EditTodoPage(settings.arguments),
          AdBannerPage.routeName: (ctx) => AdBannerPage()
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoData> _todoList = new List();
  var db = DatabaseHelper();

  bool isInited = false;

  String _versionTxt;

  bool isChecked = false;

  bool isHaveHistory = false; //是否有历史数据

  @override
  void initState() {
    super.initState();
    _getVersoinInfo();
    _getDataFromDb();
  }

  Future<void> _getVersoinInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionTxt = packageInfo.version;
  }

  Future<void> _getDataFromDb() async {
    List dbList = await db.getTotalList();
    if (dbList.length > 0) {
      isHaveHistory = true;
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
    if(CommonUtil.isToday(itemData.todoTime)) {
      if(itemData.todoState == 0) {
        _todoList.add(itemData);
      }
    } else{
      if(itemData.todoType == 1) {
        _todoList.add(itemData);
      }
    }
  }

  void _addTodo(int todoId) async {
    var result = await Navigator.pushNamed(context, EditTodoPage.routeName, arguments: todoId);
    print('add result:$result');
    if(result == 'operated') {
      _getDataFromDb();
    }
  }

  void _updateTodoState(TodoData todoData) async{
    todoData.todoState = 1;
    await db.updateItem(todoData);
    setState(() {
      _getDataFromDb();
    });
  }

  void _deleteTodo(TodoData todoData) async {
    await db.deleteItem(todoData.id);
    setState(() {
      _getDataFromDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).titleHome),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                TodoLocalizations.of(context).titleDrawer,
                style: TextStyle(color: Colors.white, fontSize: 28.0),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text(TodoLocalizations.of(context).drawerItemHistory),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(TodoLocalizations.of(context).drawerItemTip),
              onTap: () {
                Navigator.pop(context);
                _showWarmTipDialog();
              },
            ),
            ListTile(
              title: Text(TodoLocalizations.of(context).drawerItemSupport),
              onTap: () {
                Navigator.popAndPushNamed(context, AdBannerPage.routeName);
              },
            ),
            ListTile(
              title: Text(
                _versionTxt == null ? 'V1.0.0' : 'V$_versionTxt',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
      body: WillPopScope(
          child: isInited
              ? _getInitedWidget()
              : Center(
                  child: SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
          onWillPop: () {
            _showExitDialog();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo(-1);
        },
        tooltip: TodoLocalizations.of(context).addToolTip,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getInitedWidget() {
    return _todoList.length > 0
        ? RefreshIndicator(
            onRefresh: _getDataFromDb,
            child: ListView.separated(
                itemCount: _todoList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    index % 2 == 0
                        ? Divider(color: Colors.green)
                        : Divider(color: Colors.red),
                itemBuilder: (BuildContext context, int index) {
                  return _createTodoItem(_todoList[index], index);
                }
                ),
          )
        : Center(
            child: Text(
              isHaveHistory ? TodoLocalizations.of(context).goodTaskTxt : TodoLocalizations.of(context).emptyTxt,
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          );
  }

  Widget _createTodoItem(TodoData todoData, int postion) {
    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(todoData);
      },
      onTap: () {
        _addTodo(todoData.id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(width: 20.0,),
            Checkbox(
              value: isChecked,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
                Future.delayed(Duration(seconds: 1), () {
                  _updateTodoState(todoData);
                });
              },
            ),
            SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(todoData.todoType == 1 ? '(${TodoLocalizations.of(context).everyTask})${todoData.todoName}' : todoData.todoName, style: TextStyle(color: todoData.todoType == 1 ? Colors.blue:Colors.black, fontSize: 18.0), maxLines: 1,),
                SizedBox(height: 10.0,),
                Text(todoData.todoSub, style: TextStyle(color: Colors.black38, fontSize: 14.0), maxLines: 1,)
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showWarmTipDialog() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return YaCustomDialog(
            isCancel: false,
            content: TodoLocalizations.of(context).tipWarmContent,
            outsideDismiss: true,
          );
        });
  }

  void _showExitDialog() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return YaCustomDialog(
            content: TodoLocalizations.of(context).exitTip,
            confirmCallback: () {
              SystemNavigator.pop();
            },
            outsideDismiss: true,
          );
        });
  }

  void _showDeleteDialog(TodoData todoData) {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return YaCustomDialog(
            content: TodoLocalizations.of(context).deleteTip,
            confirmCallback: () {
              _deleteTodo(todoData);
            },
            outsideDismiss: true,
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    isInited = false;
  }
}
