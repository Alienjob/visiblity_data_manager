import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

class VisiblityNotificator<TValue, TCommon> extends InheritedWidget {
  VisiblityNotificator({
    super.key,
    required this.onInit,
    required this.onDispose,
    required super.child,
    this.store,
    required this.visiblityStore,
  });

  final void Function(Key key, State state, TValue? value) onInit;
  final void Function(Key key) onDispose;
  final VisiblityCommonDataStore<TCommon>? store;
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
    if (dataVersion != (store?.version??0)) {
      dataVersion = (store?.version??0);
      return true;
    }
    if (visiblityVersion != visiblityStore.version) {
      visiblityVersion = visiblityStore.version;
      return true;
    }
    return false;
  }
}
