 class VisiblityDataStore<T>{

  int version = 0;

  void update(T data){
    version++;
  }
}