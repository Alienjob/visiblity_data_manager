import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManagerCommonData<TCommon> extends VisiblityManager {
  const VisiblityManagerCommonData._({
    super.key,
    required super.child,
    required super.updateFrequency,
    required this.dataStore,
    required this.onChange,
  });

  // manageble widget can use common data
  // you need to override update function for VisiblityDataStore and onChange event
  // look num_of_visible test case
  static VisiblityManagerCommonData<TCommon> commonData<TCommon>({
    Key? key,
    required Widget child,
    Duration updateFrequency = VisiblityManager.defaultUpdateFrequency,
    required VisiblityCommonDataStore<TCommon> store,
    required void Function<TCommon>({
      VisiblityCommonDataStore<TCommon>? dataStore,
      required VisiblityStore visiblyStore,
    }) onChange,
  }) {
    return VisiblityManagerCommonData<TCommon>._(
      key: key,
      updateFrequency: updateFrequency,
      dataStore: store,
      onChange: onChange,
      child: child,
    );
  }


  final VisiblityCommonDataStore<TCommon> dataStore;
  final void Function<TCommon>({
    VisiblityCommonDataStore<TCommon>? dataStore,
    required VisiblityStore visiblyStore,
  }) onChange;

  @override
  State<VisiblityManagerCommonData> createState() => _VisiblityManagerCommonDataState();
}

class _VisiblityManagerCommonDataState<TCommon>
    extends State<VisiblityManagerCommonData<TCommon>> {
  final VisiblityStore _visiblyStore = VisiblityStore();
  Timer? _updateTimer;

  void _onInit(
    Key key,
    State state,
  ) {
    _visiblyStore.add(key, state);
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
  void didUpdateWidget(covariant VisiblityManagerCommonData<TCommon> oldWidget) {
    refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator(
      onInit: (Key key , State<StatefulWidget> state, dynamic value) => _onInit(key, state) ,
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
