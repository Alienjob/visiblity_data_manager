import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

class VisiblityManageble<TValue> extends StatefulWidget {
  const VisiblityManageble({
    required super.key,
    required this.builder, this.initValue,
  });

  final Widget Function() builder;
  final TValue? initValue;

  @override
  State<VisiblityManageble> createState() => _VisiblityManagebleState();
}

class _VisiblityManagebleState<TValue> extends State<VisiblityManageble<TValue>> {
  late void Function(Key key, State state, TValue? value) onInit;
  late void Function(Key key) onDispose;

  late TValue? value;

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
  }

  @override
  void didChangeDependencies() {
    var manager = VisiblityNotificator.of(context);
    onInit = manager.onInit;
    onDispose = manager.onDispose;
    onInit(widget.key!, this, value);
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void didUpdateWidget(VisiblityManageble<TValue> oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.initValue;
    onInit(widget.key!, this, value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }

  @override
  deactivate() {
    super.deactivate();
    onDispose(widget.key!);
  }

  @override
  dispose() {
    super.dispose();
  }
}
