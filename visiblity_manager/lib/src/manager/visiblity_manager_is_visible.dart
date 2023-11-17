import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManagerIsVisible extends VisiblityManager {
  const VisiblityManagerIsVisible._({
    super.key,
    required super.child,
    required super.updateFrequency,
  });
  // manageble widget can understand if it visible
  // use IsVisible State mixin
  // look isVisible test case
  static VisiblityManagerIsVisible isVisible({
    Key? key,
    required Widget child,
    Duration updateFrequency = VisiblityManager.defaultUpdateFrequency,
  }) {
    return VisiblityManagerIsVisible._(
      key: key,
      updateFrequency: updateFrequency,
      child: child,
    );
  }

  @override
  State<VisiblityManagerIsVisible> createState() => _VisiblityManagerIsVisibleState();
}

class _VisiblityManagerIsVisibleState
    extends State<VisiblityManagerIsVisible> {
  final VisiblityStore _visiblyStore = VisiblityStore();
  Timer? _updateTimer;

  void _onInit(
    Key key,
    State state,
  ) {
    _visiblyStore.add(key, state);
  }

  void onDispose(Key key) {
    _visiblyStore.remove(key);
  }

  void refresh() {
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
  void didUpdateWidget(covariant VisiblityManagerIsVisible oldWidget) {
    refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator(
      onInit: (Key key , State<StatefulWidget> state, dynamic value) => _onInit(key, state) ,
      onDispose: onDispose,
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
