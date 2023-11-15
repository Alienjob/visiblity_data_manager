import 'package:visiblity_manager/visiblity_manager.dart';

class NumOfVisibleStore extends VisiblityCommonDataStore<int> {
  int numOfVisible = 0;

  @override
  void update(int num) {
    if (numOfVisible != num) {
      numOfVisible = num;
      super.update(num);
    }
  }
}
