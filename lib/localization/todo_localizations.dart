
import 'package:flutter/material.dart';

class TodoLocalizations {

  bool isZh = false; //是否为中文

  TodoLocalizations(this.isZh);

  static TodoLocalizations of(BuildContext context) {
    return Localizations.of<TodoLocalizations>(context, TodoLocalizations);
  }

  String get titleHome {
    return isZh? "日常待办" : "Daily ToDo";
  }

  String get titleEditTodo {
    return isZh? "我的待办" : "My to-do";
  }

  String get titleDrawer {
    return isZh? "信息区" : "Information area";
  }

  String get titleAdBanner {
    return isZh? "帮助孱弱的小猿" : "Help the weak developer";
  }

  String get drawerItemTip {
    return isZh? "温馨提示" : "Warm Tips";
  }


  String get drawerItemSupport {
    return isZh? "支持开发者" : "Support developer";
  }

  String get addToolTip{
    return isZh ? "添加待办" : "Todo Add";
  }

  String get emptyTxt{
    return isZh?"还没有数据":"No data yet";
  }

  String get exitTip {
    return isZh ? "你确定要退出应用吗？" : "Are you sure you want to exit the app？";
  }

  String get confirm{
    return isZh ? "确定" : "Confirm";
  }

  String get cancel{
    return isZh ? "取消" : "Cancel";
  }

  String get tipItemAdBanner {
    return isZh? "随便看一看，随便点一点。" : "Just Take a look,and click a little.";
  }

}