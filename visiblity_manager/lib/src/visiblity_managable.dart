import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManageble extends StatefulWidget {
  const VisiblityManageble({
    required super.key,
    required this.builder,
  });

  final Widget Function() builder;

  @override
  State<VisiblityManageble> createState() => _VisiblityManagebleState();
}

class _VisiblityManagebleState extends State<VisiblityManageble> {
  late void Function(Key key, State volume) onInit;
  late void Function(Key key) onDispose;

  @override
  void initState() {
    super.initState();
    //_total = widget.total;
  }

  @override
  void didChangeDependencies() {
    var manager = VisiblityNotificator.of(context);
    onInit = manager.onInit;
    onDispose = manager.onDispose;
    onInit(widget.key!, this);
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void didUpdateWidget(VisiblityManageble oldWidget) {
    super.didUpdateWidget(oldWidget);
    onInit(widget.key!, this);
    //_total = widget.total;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var manager = VisiblityNotificator.of(context);
    //_maxTotal = manager.maxStaircaseTotal;

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
