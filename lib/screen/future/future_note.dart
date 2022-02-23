class FutureNote {
  Future start() async {
    print("start");
    await _getUserData();
    await _getPetData();
    await _getProductData();
    print("end");
  }

  Future _getUserData() async {
    await Future.delayed(const Duration(milliseconds: 1000),
        () => print("_getUserData complete"));
  }

  Future _getPetData() async {
    await Future.delayed(const Duration(milliseconds: 1000),
        () => print("_getPetData complete"));
  }

  Future _getProductData() async {
    await Future.delayed(const Duration(milliseconds: 1000),
        () => print("_getProductData complete"));
  }
}
