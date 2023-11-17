import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

mixin IsVisible<T extends StatefulWidget> on State<T> {

  final Key _visiblityKey = UniqueKey();

  final StreamController<bool> _changeStreamController = StreamController();
  bool _currentVisible = false;
  late void Function(Key key, State state) _onInit;
  late void Function(Key key) _onDispose;

  bool get currentVisible => _currentVisible;
  Stream<bool> get changeVisible => _changeStreamController.stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {

    context.dependOnInheritedWidgetOfExactType<VisiblityNotificator>();

    var manager = VisiblityNotificator.of(context);
    _onInit = (Key key, State state) => manager.onInit(key, state, null);
    _onDispose = manager.onDispose;
    _onInit(_visiblityKey, this);

    final newVisibleStatus = manager.visiblityStore.getVisibleKeys().contains(_visiblityKey);
    if (_currentVisible != newVisibleStatus){
      _currentVisible = newVisibleStatus;
      _changeStreamController.add(newVisibleStatus);
    } 

    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onInit(_visiblityKey, this);
    setState(() {});
  }

  @override
  deactivate() {
    super.deactivate();
    _onDispose(_visiblityKey);
  }
}
