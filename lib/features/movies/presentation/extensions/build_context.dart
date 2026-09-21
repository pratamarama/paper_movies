import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isTablet => MediaQuery.sizeOf(this).shortestSide >= 600;
}
