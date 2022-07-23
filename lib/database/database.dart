class MyDatabase {
  final int? id;
  final String? name;
  final String? password;

  MyDatabase({this.id, this.name, this.password});
  factory MyDatabase.fromMap(Map<String,dynamic> json) {
    return MyDatabase(
        id: json["id"],
        name: json["name"],
        password: json["password"],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "id" : id,
      "name" : name,
      "password" : password,
    };
  }
}