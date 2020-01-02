import 'package:daily_end/db/database_helper.dart';
import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/model/todo_data.dart';
import 'package:daily_end/widget/ya_custom_dialog.dart';
import 'package:flutter/material.dart';

class EditTodoPage extends StatefulWidget {
  static const routeName = '/page/editTodo';

  final int todoId;

  EditTodoPage(this.todoId);

  @override
  State<StatefulWidget> createState() {
    return _EditTodoPageState();
  }
}

class _EditTodoPageState extends State<EditTodoPage> {
  DatabaseHelper _databaseHelper;

  bool _isChecked = false;
  TextEditingController _todoNameController = new TextEditingController();
  TextEditingController _todoSubController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  TodoData _editTodo;

  @override
  void initState() {
    super.initState();
    print('initstate-args:${widget.todoId}');
    _databaseHelper = DatabaseHelper();
    _getTodoById();
  }

  void _getTodoById() async {
    if (widget.todoId > 0) {
      _editTodo = await _databaseHelper.getItem(widget.todoId);
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          print('name:${_editTodo.todoName}--sub:${_editTodo.todoSub}');
          if(_editTodo != null) {
            _todoNameController.text = _editTodo.todoName;
            _todoSubController.text = _editTodo.todoSub;
            _isChecked = _editTodo.todoType == 1;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).titleEditTodo),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _todoNameController,
              decoration: InputDecoration(
                  labelText: TodoLocalizations.of(context).editTodoNameLabel,
                  icon: Icon(Icons.today)),
              validator: (v) {
                return v.trim().length > 0 ? null : "";
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _todoSubController,
              decoration: InputDecoration(
                  labelText: TodoLocalizations.of(context).editTodoSubLabel,
                  icon: Icon(Icons.description)),
              validator: (v) {
                return v.trim().length > 0 ? null : "";
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                ),
                Checkbox(
                  value: _isChecked,
                  activeColor: Colors.blue, //选中时的颜色
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                    });
                  },
                ),
                Text(
                  TodoLocalizations.of(context).editTodoCheckDesc,
                  style: TextStyle(color: Colors.lightBlue, fontSize: 16.0),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                if ((_formKey.currentState as FormState).validate()) {
                  //验证通过添加或更新
                  _operateTodoDB();
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Text(
                  _editTodo == null
                      ? TodoLocalizations.of(context).addTxt
                      : TodoLocalizations.of(context).updateTxt,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {
                  _showDeleteDialog();
                },
                child: Text(
                  _editTodo == null
                      ? ''
                      : TodoLocalizations.of(context).deleteTxt,
                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return YaCustomDialog(
            content: TodoLocalizations.of(context).deleteTip,
            confirmCallback: () {
              _deleteTodo();
            },
            outsideDismiss: true,
          );
        });
  }

  void _operateTodoDB() async {
    if (_editTodo == null) {
      TodoData todoData = new TodoData();
      todoData.todoName = _todoNameController.text.trim();
      todoData.todoSub = _todoSubController.text.trim();
      todoData.todoTime = DateTime.now().millisecondsSinceEpoch;
      todoData.todoType = _isChecked ? 1 : 0;
      todoData.todoState = 0;
      await _databaseHelper.saveItem(todoData);
    } else {
      _editTodo.todoName = _todoNameController.text.trim();
      _editTodo.todoSub = _todoSubController.text.trim();
      _editTodo.todoType = _isChecked ? 1 : 0;
      await _databaseHelper.updateItem(_editTodo);
    }

    Navigator.of(context).pop('operated');
  }

  void _deleteTodo() async {
    if (_editTodo == null) {
      return;
    }

    await _databaseHelper.deleteItem(_editTodo.id);
    Navigator.of(context).pop('operated');
  }
}
