
import 'package:flutter/material.dart';

class VisiblityStore {
  final Map<Key, State> _registred = {};

  double minY = 0;
  double maxY = double.infinity;
  
  int version = 0;

  VisiblityStore();

  add(Key key, State volume) {
    _registred[key] = volume;
    version++;
  }

  remove(Key key) {
    _registred.remove(key);
    version++;
  }

  List<Key> getVisibleKeys() {
    final List<Key> result = [];
    for (final e in _registred.entries) {
      if (e.value.mounted) {
        final ro = e.value.context.findRenderObject();
        if (ro != null && ro.attached) {
          if ((ro is RenderBox) && (ro.hasSize)) {
            try {
                Offset p = ro.localToGlobal(Offset.zero);
            Size s = ro.size;
            if ((p.dy + s.height > minY) && (p.dy < maxY)) {
              result.add(e.key);
            }          
            } catch (e) {
              print('getVisibleKeys faild');
            }

          }
        }
      }
    }
    return result;
  }
}
