import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityNotificator extends InheritedWidget {
  VisiblityNotificator({
    super.key,
    required this.onInit,
    required this.onDispose,
    required super.child,
    required this.store,
    required this.visiblityStore,
  });

  final void Function(Key key, State volume) onInit;
  final void Function(Key key) onDispose;
  final VisiblityDataStore store;
  final VisiblityStore visiblityStore;

  int dataVersion = 0;
  int visiblityVersion = 0;

  static VisiblityNotificator? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VisiblityNotificator>();
  }

  static VisiblityNotificator of(BuildContext context) {
    final VisiblityNotificator? result = maybeOf(context);
    assert(result != null, 'No VisiblityManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(VisiblityNotificator oldWidget) {
    if (dataVersion != store.version) {
      dataVersion = store.version;
      return true;
    }
    if (visiblityVersion != visiblityStore.version) {
      visiblityVersion = visiblityStore.version;
      return true;
    }
    return false;
  }
}
