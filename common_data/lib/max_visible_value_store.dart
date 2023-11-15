import 'dart:math';

import 'package:flutter/src/foundation/key.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class MaxVisibleValueStore extends VisiblityCalculableDataStore<int, int> {
  int maxValue = 0;

  @override
  int? calculate(List<Key> keys) {
    maxValue = 0;
    for (var key in keys){
      maxValue = max(maxValue, registred[key]??0);
    }
    return super.calculate(keys);
  }

  @override
  void update(int data) {
    if (maxValue != data) {
      maxValue = data;
      super.update(data);
    }
  }
}
