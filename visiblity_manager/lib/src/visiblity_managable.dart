import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class VisiblityManageble extends StatefulWidget {
  const VisiblityManageble({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<VisiblityManageble> createState() => _VisiblityManagebleState();
}

class _VisiblityManagebleState extends State<VisiblityManageble> {
  late void Function(double id, State volume, double total) onInit;
  late void Function(double id) onDispose;

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
    //onInit(widget.id, this, widget.total);
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void didUpdateWidget(VisiblityManageble oldWidget) {
    super.didUpdateWidget(oldWidget);
    //onInit(widget.id, this, widget.total);
    //_total = widget.total;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var manager = VisiblityNotificator.of(context);
    //_maxTotal = manager.maxStaircaseTotal;

    return widget.child;
  }

  @override
  deactivate() {
    super.deactivate();
   // onDispose(widget.id);
  }

  @override
  dispose() {
    super.dispose();
  }
}
