import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

class VisiblityManager extends StatefulWidget {
  const VisiblityManager({
    super.key,
    required this.child,
    this.updateFrequency = defaultUpdateFrequency,
  });


  static const defaultUpdateFrequency = Duration(milliseconds: 300);
  final Widget child;
  final Duration updateFrequency;

  @override
  State<VisiblityManager> createState() => VisiblityManagerState();
}

class VisiblityManagerState
    extends State<VisiblityManager> {
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
  void didUpdateWidget(covariant VisiblityManager oldWidget) {
    refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator(
      onInit: (Key key, State<StatefulWidget> state, dynamic value) => _onInit(key, state),
      onDispose: onDispose,
      store: VisiblityCommonDataStore(),
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
