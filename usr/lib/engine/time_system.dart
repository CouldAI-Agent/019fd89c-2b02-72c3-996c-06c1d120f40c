import 'dart:async';
import 'package:flutter/material.dart';

class TimeSystem extends ChangeNotifier {
  int _hour = 8;
  int _minute = 0;
  Timer? _timer;

  int get hour => _hour;
  int get minute => _minute;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _minute += 10;
      if (_minute >= 60) {
        _minute = 0;
        _hour += 1;
        if (_hour >= 24) {
          _hour = 0;
        }
      }
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
  }

  bool get isDay => _hour >= 6 && _hour < 18;

  Color get ambientColor {
    if (_hour >= 6 && _hour < 12) return Colors.white.withOpacity(0.0);
    if (_hour >= 12 && _hour < 16) return Colors.white.withOpacity(0.0);
    if (_hour >= 16 && _hour < 19) return Colors.orange.withOpacity(0.2);
    if (_hour >= 19 && _hour < 22) return Colors.black.withOpacity(0.4);
    return Colors.black.withOpacity(0.6);
  }
}
