import 'package:daily_end/localization/todo_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodoLocalizationsDelegate extends LocalizationsDelegate<TodoLocalizations> {
  const TodoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<TodoLocalizations> load(Locale locale) {
    return SynchronousFuture<TodoLocalizations>(
      TodoLocalizations(locale.languageCode == "zh")
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<TodoLocalizations> old) {
    return false;
  }

}