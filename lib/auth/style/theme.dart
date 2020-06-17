import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFF7EA6F8);
  static const Color loginGradientEnd = const Color(0xFF85F54E);
  static const Color btnCancelGradientStart = const Color(0xFFf0163a);
  static const Color btnCancelGradientEnd = const Color(0xFFf5b642);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}