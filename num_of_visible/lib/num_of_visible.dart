import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

import 'num_of_visible_store.dart';

class NumOfVisible extends StatefulWidget {
  const NumOfVisible({super.key});

  @override
  State<NumOfVisible> createState() => _NumOfVisibleState();
}

class _NumOfVisibleState extends State<NumOfVisible> {
  final store = NumOfVisibleStore();

  List<Widget> items = [];

  void addItem() {
    final Key key = UniqueKey();
    items = List<Widget>.from([
      ...items,
      Card(
        child: VisiblityManageble(
          key: key,
          builder: () => Text(
            '$key ${store.numOfVisible}',
          ),
        ),
      )
    ]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addItem();
  }

  void onChange<TCommon>(
      {VisiblityCommonDataStore<TCommon>? dataStore,
      required VisiblityStore visiblyStore}) {
    if (dataStore is NumOfVisibleStore) {
      (dataStore as NumOfVisibleStore)
          .update(visiblyStore.getVisibleKeys().length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: addItem, icon: const Icon(Icons.add))
        ]),
        body: VisiblityManagerCommonData.commonData<int>(
          store: store,
          onChange: onChange,
          child: ListView(
            children: items,
          ),
        ),
      ),
    );
  }
}
