import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';


class IsVisiblePage extends StatefulWidget  {
  const IsVisiblePage({super.key});

  @override
  State<IsVisiblePage> createState() => _IsVisiblePageState();
}

class _IsVisiblePageState extends State<IsVisiblePage>{

  List<Widget> items = [];

  void addItem() {
    items = List<Widget>.from([
      ...items,
      const ItemWidget()
    ]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addItem();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: addItem, icon: const Icon(Icons.add))
        ]),
        body: VisiblityManagerIsVisible.isVisible(
          child: ListView(
            children: items,
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    super.key,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> with IsVisible{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
          currentVisible?'visible':'invisible',
          style: TextStyle(color: currentVisible?Colors.black:Colors.grey),
        ),

    );
  }
}
