class EmployeesModel {
  List<Employees>? employees;

  EmployeesModel({this.employees});

  factory EmployeesModel.fromJson(Map<String, dynamic> json) {
    return EmployeesModel(
      employees: List<Employees>.from(
          json["employees"].map((x) => Employees.fromJson(x))),
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.employees != null) {
  //     data['employees'] = this.employees!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Employees {
  String? name;
  int? age;
  int? salary;

  Employees({this.name, this.age, this.salary});

  factory Employees.fromJson(Map<String, dynamic> json) {
    return Employees(
        name: json['name'],
        age: json['age'],
        salary: json['salary'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['age'] = this.age;
  //   data['salary'] = this.salary;
  //   return data;
  // }
}
