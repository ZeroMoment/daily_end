import 'package:daily_end/widget/net_loading_dialog.dart';
import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditTodoPageState();
  }

}

class _EditTodoPageState extends State<EditTodoPage> {

  @override
  void initState() {
    super.initState();
    var args = ModalRoute.of(context).settings.arguments;

    print('args:$args');
  }

  @override
  Widget build(BuildContext context) {

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

