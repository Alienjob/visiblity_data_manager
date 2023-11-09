import 'package:visiblity_manager/visiblity_data_store.dart';

class NumOfVisibleStore extends VisiblityDataStore<int> {
  
  int numOfVisible = 0;
  
  @override
  void update(int num){
    numOfVisible = num;
    version++;
  }
}