import 'dart:ui';

class CommonUtil {

  /**
   * 是否是今天
   */
  static bool isToday(int milliseconds, {bool isUtc = false}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old =
    DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /**
   * 是否是同一天
   */
  static bool dayIsEqual(int oldMill, int newMill) {
    if (oldMill == null || oldMill == 0 || newMill == null || newMill == 0) return false;
    DateTime old = DateTime.fromMillisecondsSinceEpoch(oldMill);
    DateTime now = DateTime.fromMillisecondsSinceEpoch(newMill);
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  static Color hexToColor(String s) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (s == null || s.length != 7 || int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#ce5544';
    }

    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}