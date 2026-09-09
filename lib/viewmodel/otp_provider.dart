import 'dart:async';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  Timer? _timer;

  int remainingSeconds = 0;

  void startOtpTimer() {
    _timer?.cancel();

    remainingSeconds = 120;
    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds > 0) {
          remainingSeconds--;
          notifyListeners();
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void resetTimer() {
  _timer?.cancel();
  remainingSeconds = 120;
  notifyListeners();
}
}