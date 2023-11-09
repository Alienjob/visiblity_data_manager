import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

import 'num_of_visible_store.dart';

class NumOfVisible extends StatelessWidget {
  NumOfVisible({super.key});
  final store = NumOfVisibleStore();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: VisiblityManager(
          store: store,
          child: ListView(
            children: [
              Card(
                child: VisibleManageble(
                  child: Text(
                    '${store.numOfVisible}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
