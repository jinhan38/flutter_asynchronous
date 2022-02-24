class RoomModel {
  String? name;
  int? num;
  String? doc;

  RoomModel({required this.name, required this.num, required this.doc});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(name: json["name"], num: json["num"], doc : json["doc"]);
  }


  @override
  String toString() {
    return "RoomModel(name : $name, num : $num, doc : $doc)";
  }

  @override
  bool operator ==(Object other) {
    if (other is RoomModel) {
      return name == other.name && num == other.num && doc == other.doc;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}
