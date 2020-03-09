
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SchulteProvider extends ChangeNotifier {

  Timer timer;
  double totalTime;
  bool isStarted = false;
  int totalCell = 0;
  int count = 25;

  List<Color> conColor = List<Color>();
  List<int> data;
  List<int> curSel;

  List<AnimationController> controllers;
  List<Animation<Color>> animations;

  SchulteProvider() {
    if(isStarted) {
      timer.cancel();
    }
    isStarted = false;
    totalCell = count;

    totalTime = 0;
    List.generate(totalCell, (index) {
      conColor.add(Colors.white);
    });

    data = List<int>();
    List.generate(totalCell, (index) {
      data.add(index+1);
    });
    data.shuffle();
    curSel = List<int>();

  }

  resetValue() {
    if (isStarted) {
      timer.cancel();
    }
    isStarted = false;

    totalTime = 0;
    conColor = List.generate(totalCell, (i) => conColor[i] = Colors.white);

    data = List<int>();
    List.generate(totalCell, (i) => data.add(i+1));
    data.shuffle();
    curSel = List<int>();
    notifyListeners();
  }

  startRecordTime() {
    Timer.periodic(Duration(milliseconds: 100), (_) {
      isStarted = true;
      totalTime += 0.1;
      notifyListeners();
    });
  }

  tapStart() {
    if (!isStarted) {
      timer = Timer.periodic(Duration(milliseconds: 100), (_) {
        totalTime += 0.1;
        totalTime = totalTime;
        notifyListeners();
      });
      isStarted = true;
    } else {
      timer.cancel();
      isStarted = false;
    }
    notifyListeners();
  }

  startPlay() {
    if (!isStarted) {
      tapStart();
    }
  }

  changeCount(){
    if (count==16){
      count=25;
    }
    else{
      count=16;
    }
    totalCell=count;
    // resetValue();
    curSel=List<int>();
    data = List<int>();
    List.generate(totalCell, (i) => data.add(i+1));
    data.shuffle();
    if(isStarted) {
      timer.cancel();
    }

    totalTime=0;
    isStarted=false;
    notifyListeners();
  }

  tapCell(i, frontStr, afterStr) {
    int prevValue = curSel.length > 0 ? curSel.last : 0;
    startPlay();
    if (data[i] - prevValue != 1) {
      animations[i] = ColorTween(
        begin: Colors.white,
        end: Colors.red,
      ).animate(controllers[i]);
    } else {
      animations[i] = ColorTween(
        begin: Colors.white,
        end: Colors.green,
      ).animate(controllers[i]);
      curSel.add(data[i]);
      curSel = curSel;
    }

    if (data[i] == totalCell  && curSel.length == totalCell ) {
      timer.cancel();
      Fluttertoast.showToast(
          msg: "$frontStr${totalTime.toStringAsFixed(1)}$afterStr",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
    controllers[i].forward(from: 0).then((_) => controllers[i].reverse());

  }

}