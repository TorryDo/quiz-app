class IdGenerator{
  static int _runtimeId = 0;

  int getRuntimeId(){
    _runtimeId++;
    return _runtimeId;
  }

  int getUniqueId(){
    throw Exception('not implemented');
  }

}