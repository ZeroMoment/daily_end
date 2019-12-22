import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  Future _incrementCounter() async {
    final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'daily_database.db'),
        onCreate: (db, version)=>db.execute("CREATE TABLE dailysettle(id INTEGER PRIMARY KEY, content TEXT, contentSub TEXT, endState INTEGER)"),
    onUpgrade: (db, oldVersion, newVersion) {

    },
    version: 1,
    );
//    setState(() {
//      _counter++;
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) => index % 2 == 0
              ? Divider(color: Colors.green)
              : Divider(
                  color: Colors.red,
                ),
          itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text("title $index"), subtitle: Text("body $index"))),
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
