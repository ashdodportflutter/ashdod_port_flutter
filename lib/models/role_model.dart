class RoleModel {
  int? orderBy;
  String? name;
  String? id;

  RoleModel(Map<String, dynamic> map) {
    orderBy = map['orderBy'];
    name = map['name'];
    id = map['id'];
  }
}