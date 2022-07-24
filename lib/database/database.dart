class MyDatabase {
  final int? id;
  final String? name;
  final String? email;
  final String? dob;

  MyDatabase({this.id,this.dob, this.name, this.email});
  factory MyDatabase.fromMap(Map<String,dynamic> json) {
    return MyDatabase(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      dob: json["dob"],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "id" : id,
      "name" : name,
      "email" : email,
      "dob" : dob,
    };
  }
}