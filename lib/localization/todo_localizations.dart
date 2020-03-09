import 'package:flutter/material.dart';

class TodoLocalizations {
  bool isZh = false; //是否为中文

  TodoLocalizations(this.isZh);

  static TodoLocalizations of(BuildContext context) {
    return Localizations.of<TodoLocalizations>(context, TodoLocalizations);
  }

  String get titleHome {
    return isZh ? "日常待办" : "Daily ToDo";
  }

  String get titleEditTodo {
    return isZh ? "我的待办" : "My to-do";
  }

  String get titleDrawer {
    return isZh ? "信息区" : "Information area";
  }

  String get titleAdBanner {
    return isZh ? "帮助孱弱的小猿" : "Help the weak developer";
  }

  String get drawerItemHistory {
    return isZh ? "历史待办" : "History of ToDo";
  }

  String get drawerItemTip {
    return isZh ? "温馨提示" : "Warm Tips";
  }

  String get editTodoNameLabel {
    return isZh ? "标题" : "Title";
  }

  String get editTodoSubLabel {
    return isZh ? "描述" : "Description";
  }

  String get editTodoCheckDesc {
    return isZh ? "是否是每日必做？" : "Is it must to do it every day?";
  }

  String get addTxt {
    return isZh ? "添加" : "Add";
  }

  String get updateTxt {
    return isZh ? "更新" : "Update";
  }

  String get deleteTxt {
    return isZh ? "删除" : "Delete";
  }

  String get drawerItemSupport {
    return isZh ? "支持开发者" : "Support developer";
  }

  String get drawerItemPuzzle {
    return isZh ? "益智" : "Puzzle";
  }

  String get puzzleTitle {
    return isZh ? "舒尔特方格" : "Schulte Square";
  }

  String get addToolTip {
    return isZh ? "添加待办" : "Todo Add";
  }

  String get emptyTxt {
    return isZh ? "还没有数据" : "No data yet";
  }

  String get goodTaskTxt {
    return isZh ? "都完成了，很棒！" : "It's all done, great!";
  }

  String get everyTask {
    return isZh ? "每日任务" : "Daily tasks";
  }

  String get unDone {
    return isZh ? "未完成" : "UnDone";
  }

  String get done {
    return isZh ? "已完成" : "Done";
  }

  String get exitTip {
    return isZh ? "你确定要退出应用吗？" : "Are you sure you want to exit the app？";
  }

  String get deleteTip {
    return isZh ? "确定要删除任务吗？" : "Are you sure you want to delete the task？";
  }

  String get confirm {
    return isZh ? "确定" : "Confirm";
  }

  String get cancel {
    return isZh ? "取消" : "Cancel";
  }

  String get standardText {
    return isZh ? "标准" : "Standard";
  }

  String get standDescText {
    return isZh ? "16秒内完成16格，25格同样标准" : "16 grids completed in 16 seconds, 25 grids are the same standard";
  }

  String get congratFrontText {
    return isZh ? "恭喜你，在 " : "Congratulations, it's done in ";
  }

  String get congratAfterText {
    return isZh ? " 秒内完成~ " : " seconds~";
  }

  String get gridText {
    return isZh ? "格" : "grid";
  }

  String get changeTopicText {
    return isZh ? "换一题" : "Another topic";
  }

  String get tipItemAdBanner {
    return isZh ? "随便看一看，随便点一点。" : "Just Take a look,and click a little.";
  }

  String get tipWarmContent {
    return isZh
        ? "每日进入app才能产生历史数据，应用没有连接任何服务器，所有数据都存储在本地。请不要清除应用的本地缓存数据。经济情况好一些的时候，会加上数据上传。"
        : "The application is not connected to any server and all data is stored locally. Do not clear your app ’s local cache data.When the economic situation is better, data upload will be added.Now,Enter the app daily to generate historical data";
  }
}
