import 'package:flutter/material.dart';

class VisiblityNotificator extends InheritedWidget {
  const VisiblityNotificator({
    super.key,
    required this.onInit,
    required this.onDispose,
    required super.child,
  });

  final void Function(double key, State volume, double total) onInit;
  final void Function(double key) onDispose;

  static VisiblityNotificator? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VisiblityNotificator>();
  }

  static VisiblityNotificator of(BuildContext context) {
    final VisiblityNotificator? result = maybeOf(context);
    assert(
        result != null, 'No VisiblityManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(VisiblityNotificator oldWidget) => true;
    //  oldWidget.maxStaircaseTotal != maxStaircaseTotal;
}