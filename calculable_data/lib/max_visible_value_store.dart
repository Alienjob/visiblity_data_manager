import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

class MaxVisibleValueStore extends VisiblityCalculableDataStore<double, double> {
  double maxValue = 0;

  @override
  double? calculate(List<Key> keys) {
    maxValue = 0;
    for (var key in keys){
      maxValue = max(maxValue, registred[key]??0);
    }
    super.calculate(keys);
    return maxValue;
  }

  @override
  void update(double data) {
    if (maxValue != data) {
      maxValue = data;
      super.update(data);
    }
  }
}
