import 'package:flutter/material.dart';
import 'package:idz_reg/models/employees_model.dart';

import '../apis/idz_test_api.dart';

class EmployeesApiProvider extends ChangeNotifier {
    // EmployeesModel _employeesModel;
    List<Employees> employees = [];
    EmployeesApiProvider(){
      loadEmployees();
    }
    Future loadEmployees() async {
      final employees = await IDZ.getEmployees();
      this.employees = employees;
      notifyListeners();
    }
}