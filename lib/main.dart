import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/localization/todo_localizations_delegate.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/page/ad_banner_page.dart';
import 'package:daily_end/page/edit_todo_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'widget/ya_custom_dialog.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-1984117899270114~3221984939");

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        TodoLocalizationsDelegate()
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

  @override
  void initState() {
    super.initState();

    _getVersoinInfo();
    _getDataFromDb();
  }


  void _getVersoinInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionTxt = packageInfo.version;
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
        title: Text(TodoLocalizations.of(context).titleHome),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(TodoLocalizations.of(context).titleDrawer, style: TextStyle(color: Colors.white, fontSize: 28.0),),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text(TodoLocalizations.of(context).drawerItemTip),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(TodoLocalizations.of(context).drawerItemSupport),
              onTap: () {
                Navigator.popAndPushNamed(context, AdBannerPage.routeName);
              },
            ),
            ListTile(
              title: Text(_versionTxt == null ? 'V1.0.0' : 'V$_versionTxt', style: TextStyle(color: Colors.grey),),
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
        onPressed: _addTodo,
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
                        : Divider(
                            color: Colors.red,
                          ),
                itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text("title $index"),
                    subtitle: Text("body $index"))),
          )
        : Center(
            child: Text(
              TodoLocalizations.of(context).emptyTxt,
              style: TextStyle(color: Colors.blue, fontSize: 22.0),
            ),
          );
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

  @override
  void dispose() {
    super.dispose();
    isInited = false;
  }
}
