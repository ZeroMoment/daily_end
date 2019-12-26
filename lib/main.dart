import 'package:daily_end/page/edit_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:sqflite/sqflite.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily End',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  int _counter = 0;

  void _incrementCounter() {

    Navigator.of(context).push(
        MaterialPageRoute(
          //没有传值
            builder: (context)=>EditTodoPage()
        )
    );


//    final Future<Database> database = openDatabase(
//        join(await getDatabasesPath(), 'daily_database.db'),
//        onCreate: (db, version)=>db.execute("CREATE TABLE dailysettle(id INTEGER PRIMARY KEY, content TEXT, contentSub TEXT, endState INTEGER)"),
//    onUpgrade: (db, oldVersion, newVersion) {
//
//    },
//    version: 1,
//    );
//    setState(() {
//      _counter++;
//    });
  }

  YYDialog YYAlertDialogWithDivider(BuildContext context) {
    return YYDialog().build(context)
      ..width = 320
      ..borderRadius = 15.0
      ..text(
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        text: "确定要退出应用吗?",
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
      ..divider()
      ..doubleButton(
        padding: EdgeInsets.only(top: 10.0),
        gravity: Gravity.center,
        withDivider: true,
        text1: "取消",
        color1: Colors.redAccent,
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        onTap1: () {
          print("取消");
        },
        text2: "确定",
        color2: Colors.redAccent,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        onTap2: () {
          print("确定");
          SystemNavigator.pop();
        },
      )
    ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => index % 2 == 0
                  ? Divider(color: Colors.green)
                  : Divider(
                color: Colors.red,
              ),
              itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text("title $index"), subtitle: Text("body $index"))), onWillPop: (){
            print('也有返回？');
            YYAlertDialogWithDivider(context);
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

/**
 * Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(
    'You have pushed the button this many times:',
    ),
    Text(
    '$_counter',
    style: Theme.of(context).textTheme.display1,
    ),
    ],
    )
 */
}

class DailyContent {
  String content;
  String contentSub;
  int endState;

  DailyContent({this.content, this.contentSub, this.endState});

  factory DailyContent.fromJson(Map<String, dynamic> parsedJson) {
    return DailyContent(
        content: parsedJson['content'],
        contentSub: parsedJson['contentSub'],
        endState: parsedJson['endState']);
  }

  Map<String, dynamic> toJson() {
    return {'content': content, 'contentSub': contentSub, 'endState': endState};
  }

  //
  var dailyContent = DailyContent(content: 'test', contentSub: 'hehe', endState: 1);


}
