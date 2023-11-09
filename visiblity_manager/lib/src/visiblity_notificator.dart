import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityNotificator extends InheritedWidget {
  const VisiblityNotificator({
    super.key,
    required this.onInit,
    required this.onDispose,
    required super.child,
    required this.store,
  });

  final void Function(double key, State volume, double total) onInit;
  final void Function(double key) onDispose;
  final VisiblityDataStore store;
  
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
  bool updateShouldNotify(VisiblityNotificator oldWidget) => 
    oldWidget.store.version != store.version;
}