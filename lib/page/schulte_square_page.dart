import 'dart:math';

import 'package:daily_end/localization/todo_localizations.dart';
import 'package:daily_end/providers/schulte.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchulteSquarePage extends StatelessWidget {
  static const routeName = '/page/schultePage';

  var table = AnimContainer();
  var timer = CountTimer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(TodoLocalizations.of(context).puzzleTitle),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SchulteProvider(),
          )
        ],
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            Text(TodoLocalizations.of(context).standardText, style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text(TodoLocalizations.of(context).standDescText, style: TextStyle(fontSize: 16),),
            SizedBox(height: 15,),
            SizedBox(
              height: 450,
              child: table,
            ),
            timer
          ],
        ),
      ),
    );
  }
}

class CountTimer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SchulteProvider>(context);

    return SizedBox(
        height: 160,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    "${provider.totalTime.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Container(
                child: Flexible(
                  flex: 2,
                  child: MaterialButton(
                    // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    splashColor: Colors.transparent,
                    color: Colors.blueAccent,
                    onPressed: () {
                      provider.changeCount();
                    },
                    child: Text(
                      provider.count==16 ? "25${TodoLocalizations.of(context).gridText}" : "16${TodoLocalizations.of(context).gridText}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Container(
                child: Flexible(
                  flex: 2,
                  child: MaterialButton(
                    // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    splashColor: Colors.transparent,
                    color: Colors.blueAccent,
                    onPressed: () {
                      provider.resetValue();
                    },
                    child: Text(
                      TodoLocalizations.of(context).changeTopicText,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ));
  }
}


class AnimContainer extends StatefulWidget {
  AnimContainer({Key key}) : super(key: key);

  _AnimContainerState createState() => _AnimContainerState();
}

class _AnimContainerState extends State<AnimContainer>
    with TickerProviderStateMixin {

  List<Animation<Color>> animation;
  List<AnimationController> controller;

  String frontStr;
  String afterStr;

  @override
  void initState() {
    super.initState();
    animation = List<Animation<Color>>();
    controller = List<AnimationController>();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SchulteProvider>(context);

    frontStr = TodoLocalizations.of(context).congratFrontText;
    afterStr = TodoLocalizations.of(context).congratAfterText;

    int count=provider.count;
    for (int i = 0; i < count; i++) {
      controller.add(AnimationController(
          duration: const Duration(milliseconds: 500), vsync: this));
      animation.add(ColorTween(
        begin: Colors.white,
        end: Colors.green,
      ).animate(controller[i])
        ..addListener(() {
          setState(() {});
        }));
    }
    provider.animations = animation;
    provider.controllers = controller;
    return GridView.count(
      crossAxisCount: sqrt(count).round(),
      children: List.generate(
          count,
              (index) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: provider.animations[index].value, border: Border.all(width: 1)),
              child: Container(
                  child: FlatButton(
                    padding: EdgeInsets.all(count==25? 10:20),
                    child: Text(
                      "${provider.data[index]}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      provider.tapCell(index, frontStr, afterStr);
                    },
                  )))).toList(),
    );
  }
}