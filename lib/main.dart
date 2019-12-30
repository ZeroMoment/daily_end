import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/page/edit_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/ya_custom_dialog.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CN')
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          EditTodoPage.routeName: (ctx) => EditTodoPage(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      home: MyHomePage(title: 'Daily Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoData> _todoList = new List();
  var db = DatabaseHelper();

  bool isInited = false;

  @override
  void initState() {
    super.initState();

    _getDataFromDb();
  }

  void _getDataFromDb() async {
    List dbList = await db.getTotalList();
    if (dbList.length > 0) {
      dbList.forEach((todoData) {
        TodoData itemData = TodoData.fromMap(todoData);
        _todoList.add(itemData);
      });
    }

    setState(() {
      isInited = true;
    });
  }

  void _addTodo() {
    Navigator.pushNamed(context, EditTodoPage.routeName, arguments: 'dbid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        onPressed: _addTodo,
        tooltip: 'Todo Add',
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
                        : Divider(
                            color: Colors.red,
                          ),
                itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text("title $index"),
                    subtitle: Text("body $index"))),
          )
        : Center(
            child: Text(
              'No data yet',
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          );
  }

  void _showExitDialog() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return YaCustomDialog(
            content: 'Are you sure you want to exit the app？',
            confirmCallback: () {
              SystemNavigator.pop();
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
