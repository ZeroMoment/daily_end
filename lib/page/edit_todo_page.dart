import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditTodoPageState();
  }

}

class _EditTodoPageState extends State<EditTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的待办'),
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }

}