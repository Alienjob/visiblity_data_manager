import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManagerCalculableData<TValue, TCommon> extends VisiblityManager {
  const VisiblityManagerCalculableData._({
    super.key,
    required super.child,
    required super.updateFrequency,
    required this.dataStore,
    required this.onChange,
  });

  // manageble widget contains data, common data can calculate from  manageble widget data
  // you need to override update function for VisiblityDataStore and set onChange event
  // look calculable test case
  static VisiblityManagerCalculableData<TValue, TCommon>
      calculable<TValue, TCommon>({
    Key? key,
    required Widget child,
    Duration updateFrequency = VisiblityManager.defaultUpdateFrequency,
    required VisiblityCalculableDataStore<TValue, TCommon> store,
    required void Function<TValue, TCommon>({
      VisiblityCalculableDataStore<TValue, TCommon>? dataStore,
      required VisiblityStore visiblyStore,
    }) onChange,
  }) {
    return VisiblityManagerCalculableData<TValue, TCommon>._(
      key: key,
      updateFrequency: updateFrequency,
      dataStore: store,
      onChange: onChange,
      child: child,
    );
  }

  final VisiblityCalculableDataStore<TValue, TCommon> dataStore;
  final void Function<TValue, TCommon> ({
    VisiblityCalculableDataStore<TValue, TCommon> dataStore,
    required VisiblityStore visiblyStore,
  }) onChange;

  @override
  State<VisiblityManager> createState() =>
      _VisiblityManagerCalculableDataState();
}

class _VisiblityManagerCalculableDataState<TValue, TCommon>
    extends State<VisiblityManagerCalculableData<TValue, TCommon>> {
  final VisiblityStore _visiblyStore = VisiblityStore();
  Timer? _updateTimer;

  void onInit(
    Key key,
    State state,
    TValue? value,
  ) {
    _visiblyStore.add(key, state);
    widget.dataStore.add(key, value!);
    widget.onChange(dataStore: widget.dataStore, visiblyStore: _visiblyStore);
  }

  void onDispose(Key key) {
    _visiblyStore.remove(key);
    widget.dataStore.remove(key);
    widget.onChange(dataStore: widget.dataStore, visiblyStore: _visiblyStore);
  }

  void refresh() {
    widget.onChange(dataStore: widget.dataStore, visiblyStore: _visiblyStore);
    _updateTimer?.cancel();
    _updateTimer = null;
    _updateTimer = Timer.periodic(widget.updateFrequency, (timer) {
      if (context.mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    refresh();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant VisiblityManagerCalculableData<TValue, TCommon> oldWidget) {
    refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator<TValue, TCommon>(
      onInit: onInit,
      onDispose: onDispose,
      store: widget.dataStore,
      visiblityStore: _visiblyStore,
      child: widget.child,
    );
  }

  void _updateVisibleStrict(BuildContext context) {
    final ro = context.findRenderObject();
    if ((ro is RenderBox) && (ro.hasSize)) {
      try {
        Offset position = ro.localToGlobal(Offset.zero);
        Size size = ro.size;
        _visiblyStore.minY = position.dy;
        _visiblyStore.maxY = position.dy + size.height;        
      } catch (e) {
        print('_updateVisibleStrict faild');
      }

    }
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _updateTimer = null;
    super.dispose();
  }
}
