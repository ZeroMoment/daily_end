import 'package:flutter/cupertino.dart';

class TodoLocalizations {

  bool isZh = false; //是否为中文

  TodoLocalizations(this.isZh);

  static TodoLocalizations of(BuildContext context) {
    return Localizations.of<TodoLocalizations>(context, TodoLocalizations);
  }

}