class RoleModel {
  int? orderBy;
  String? name;
  String? id;
  DateTime? birthDate;
  final Map<String, dynamic> map;

  RoleModel({required this.map}) {
    orderBy = map['orderBy'];
    name = map['name'];
    id = map['id'];
    if (map['birthDate'] != null) {
      birthDate = DateTime.fromMillisecondsSinceEpoch(map['birthDate']);
    }
  }

  Map<String, dynamic> get toJson {
    return map;
  }
}