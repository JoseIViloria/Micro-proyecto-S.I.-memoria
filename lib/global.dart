import 'cardWidget.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static int clicks = 0;
  static Duration playTime = Duration.zero;
  static String durationString = '';
  static CardWidget? firstCardSelected;
  static CardWidget? secondCardSelected;
  static CardWidgetState? firstCardState;
  static CardWidgetState? secondCardState;

  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestTime', playTime.inMilliseconds);
    await prefs.setString('bestTimeString', durationString);
  }

  static Future<int> loadBestTime() async {
    final prefs = await SharedPreferences.getInstance();
    int? bestTime = prefs.getInt('bestTime');
    return bestTime ?? 0;
  }

  static Future<String> loadBestTimeString() async {
    final prefs = await SharedPreferences.getInstance();
    String? bestTimeString = prefs.getString('bestTimeString');
    return bestTimeString ?? 'No existe';
  }
}