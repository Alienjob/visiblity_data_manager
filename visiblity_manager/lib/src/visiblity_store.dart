
import 'package:flutter/material.dart';

class VisiblityStore {
  final Map<double, State> _registred = {};
  Map<double, State> get registred => _registred;

  double minY = 0;
  double maxY = double.infinity;

  VisiblityStore();

  add(double key, State volume) {
    _registred[key] = volume;
  }

  remove(double key) {
    _registred.remove(key);
  }

  List<double> getVisibleKeys() {
    final List<double> result = [];
    for (final e in _registred.entries) {
      //print('${e.key} mounted ${e.value.mounted}');
      if (e.value.mounted) {
        final ro = e.value.context.findRenderObject();
        //print('${e.key} ro $ro');
        if (ro != null) {
          if ((ro is RenderBox) && (ro.hasSize)) {
            Offset p = ro.localToGlobal(Offset.zero);
            Size s = ro.size;
            if ((p.dy + s.height > minY) && (p.dy < maxY)) {
              result.add(e.key);
            }
          }
        }
      }
    }
    return result;
  }
}
