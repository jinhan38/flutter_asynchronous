class Note {
  start() {
    print("start");
    _getUserData(() {
      print("_getUserData complete");
      _getPetData(() {
        print("_getPetData complete");
        _getProductData(() {
          print("_getProductData complete");
        });
      });
    });
    print("end");
  }

  _getUserData(Function callback) {
    Future.delayed(const Duration(milliseconds: 600), () => callback());
  }

  _getPetData(Function callback) {
    Future.delayed(const Duration(milliseconds: 600), () => callback());
  }

  _getProductData(Function callback) {
    Future.delayed(const Duration(milliseconds: 600), () => callback());
  }
}
