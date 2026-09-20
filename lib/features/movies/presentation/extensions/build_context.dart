import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;
}
