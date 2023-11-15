import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManager<TValue, TCommon> extends StatefulWidget {
  const VisiblityManager._({
    super.key,
    required this.child,
    this.updateFrequency = defaultUpdateFrequency,
    required this.dataStore,
    required this.onChange,
  });

  // manageble widget can understand if it visible
  // use IsVisible State mixin
  // look isVisible test case
  VisiblityManager.isVisible({
    super.key,
    required this.child,
    this.updateFrequency = defaultUpdateFrequency,
  })  : dataStore = VisiblityCommonDataStore<TCommon>(),
        onChange = _isVisibleOnChange;

  static void _isVisibleOnChange<TCommon>({
    VisiblityCommonDataStore<TCommon>? dataStore,
    required VisiblityStore visiblyStore,
  }) {}

  // manageble widget can use common data
  // you need to override update function for VisiblityDataStore and onChange event
  // look num_of_visible test case
  static VisiblityManager<void, TCommon> commonData<TCommon>({
    Key? key,
    required Widget child,
    Duration updateFrequency = defaultUpdateFrequency,
    required VisiblityCommonDataStore<TCommon> store,
    required void Function<TCommon>({
      VisiblityCommonDataStore<TCommon>? dataStore,
      required VisiblityStore visiblyStore,
    }) onChange,
  }) {
    return VisiblityManager<void, TCommon>._(
      key: key,
      updateFrequency: updateFrequency,
      dataStore: store,
      onChange: onChange,
      child: child,
    );
  }

  // manageble widget contains data, common data can calculate from  manageble widget data
  // you need to override update function for VisiblityDataStore and set onChange event
  // look calculable test case
  static VisiblityManager<TValue, TCommon> calculable<TValue, TCommon>({
    Key? key,
    required Widget child,
    Duration updateFrequency = defaultUpdateFrequency,
    required VisiblityCalculableDataStore<TValue, TCommon> store,
    required void Function({
      VisiblityCommonDataStore<TCommon>? dataStore,
      required VisiblityStore visiblyStore,
    }) onChange,
  }) {
    return VisiblityManager<TValue, TCommon>._(
      key: key,
      updateFrequency: updateFrequency,
      dataStore: store,
      onChange: onChange,
      child: child,
    );
  }


  static const defaultUpdateFrequency = Duration(milliseconds: 300);
  final Widget child;
  final VisiblityCommonDataStore<TCommon> dataStore;
  final Duration updateFrequency;
  final void Function({
    VisiblityCommonDataStore<TCommon>? dataStore,
    required VisiblityStore visiblyStore,
  }) onChange;

  @override
  State<VisiblityManager> createState() => _VisiblityManagerState();
}

class _VisiblityManagerState<TValue, TCommon>
    extends State<VisiblityManager<TValue, TCommon>> {
  final VisiblityStore _visiblyStore = VisiblityStore();
  Timer? _updateTimer;

  void onInit(
    Key key,
    State state,
    TValue? value,
  ) {
    _visiblyStore.add(key, state);
    if (widget.dataStore is VisiblityCalculableDataStore) {
      (widget.dataStore as VisiblityCalculableDataStore).add(key, value);
    }
    widget.onChange(dataStore: widget.dataStore, visiblyStore: _visiblyStore);
  }

  void onDispose(Key key) {
    _visiblyStore.remove(key);
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
  void didUpdateWidget(covariant VisiblityManager<TValue, TCommon> oldWidget) {
    refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator(
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
      Offset position = ro.localToGlobal(Offset.zero);
      Size size = ro.size;
      _visiblyStore.minY = position.dy;
      _visiblyStore.maxY = position.dy + size.height;
    }
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _updateTimer = null;
    super.dispose();
  }
}
