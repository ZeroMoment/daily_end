import 'package:daily_end/widget/net_loading_dialog.dart';
import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  static const routeName = '/page/editTodo';

  final String todoId;

  EditTodoPage(this.todoId);

  @override
  State<StatefulWidget> createState() {
    return _EditTodoPageState();
  }

}

class _EditTodoPageState extends State<EditTodoPage> {

  @override
  void initState() {
    super.initState();
    print('initstate。。》。。。。。。。');

    print('initstate-args:${widget.todoId}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies.....');
  }

  @override
  Widget build(BuildContext context) {
    print('build。。。');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('我的待办'),
      ),
      body: Container(
      ),
    );
  }

  void _showLoadingDialog(String tipTxt) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return new NetLoadingDialog(tipTxt: tipTxt,);
        });
  }

}

