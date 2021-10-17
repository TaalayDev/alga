import 'package:intl/intl.dart';
import 'package:get/get.dart';

class Helper {
  static parseDate(date) {
    DateTime now = DateTime.now();
    String result = date.toString();
    try {
      DateTime dateTime = DateTime.parse(date).toLocal();
      result = DateFormat('dd/MM/yyyy').format(dateTime) +
          ' ${doubleDigit(dateTime.hour)}:${doubleDigit(dateTime.minute)}';

      if (DateFormat('yyyy-MM-dd').format(now) ==
          DateFormat('yyyy-MM-dd').format(dateTime)) {
        result =
            '${'today'.tr} ${doubleDigit(dateTime.hour)}:${doubleDigit(dateTime.minute)}';
      } else {
        final difference = int.tryParse(DateFormat('yyyyMMdd').format(now)) ??
            0 - (int.tryParse(DateFormat('yyyyMMdd').format(dateTime)) ?? 0);
        if (difference == 1) {
          result =
              '${'yesterday'.tr} ${doubleDigit(dateTime.hour)}:${doubleDigit(dateTime.minute)}';
        }
      }
    } catch (e) {
      print('parseDate exception $date ${e.toString()}');
    }
    return result;
  }

  static doubleDigit(int i) {
    if (i > 10) return '$i';
    return '0$i';
  }

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url.isNotEmpty, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1) ?? url;
    }

    return url;
  }

  static String numbersWithSpaces(int number, {int spaceEvery = 3}) {
    String numStr = number.toString();
    String result = '';

    int spaceCount = spaceEvery;
    for (int index = numStr.length - 1; index >= 0; index--) {
      if (spaceCount == 0) {
        result += ' ';
        spaceCount = spaceEvery;
      }
      result += numStr[index];
      spaceCount--;
    }

    return result.split('').reversed.join();
  }
}
