import 'package:flutter/material.dart';
import 'package:visiblity_manager/src/visiblity_data.dart';

class VisiblityCommonDataStore<TCommon> {
  int version = 0;

  TCommon? data;

  void update(TCommon data) {
    if (data != this.data) {
      this.data = data;
    }
    version++;
  }
}

class VisiblityCalculableDataStore<TValue, TCommon>
    extends VisiblityCommonDataStore<TCommon> {
  final Map<Key, TValue> registred = {};

  void add(Key key, TValue? data) {
    if (data == null) {
      registred.remove(key);
    } else {
      registred[key] = data;
    }
  }

  void remove(Key key) {
    registred.remove(key);
  }

  TCommon? calculate(List<Key> keys) {
    return null;
  }
}
