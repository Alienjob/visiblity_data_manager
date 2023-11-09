import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_data_store.dart';
import 'package:visiblity_manager/visiblity_manager.dart';
import 'package:visiblity_manager/visiblity_store.dart';

// Виджет
class VisiblityManager extends StatefulWidget {
  const VisiblityManager({
    super.key,
    required this.child,
    this.updateFrequency = const Duration(milliseconds: 300),
    required this.store,
  });

  final Widget child;
  final VisiblityDataStore store;
  final Duration updateFrequency;

  @override
  State<VisiblityManager> createState() => _VisiblityManagerState();
}

// Стейт
class _VisiblityManagerState extends State<VisiblityManager> {
  final VisiblityStore _visiblyStore = VisiblityStore();
  Timer? _updateTimer;

  void onInit(double key, State volume, double total) {
    _visiblyStore.add(key, volume);
  }

  void onDispose(double key) {
    _visiblyStore.remove(key);
  }

  @override
  void didUpdateWidget(covariant VisiblityManager oldWidget) {
    _updateTimer?.cancel();
    _updateTimer = null;
    _updateTimer = Timer.periodic(widget.updateFrequency, (timer) {
      if (context.mounted) {
        setState(() {});
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _updateVisibleStrict(context);
    return VisiblityNotificator(
      onInit: onInit,
      onDispose: onDispose,
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
