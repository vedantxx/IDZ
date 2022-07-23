import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/employees_model.dart';
import 'package:http/http.dart' as http;

class IDZ {
  static Future<List<Employees>> getEmployees() async {

    final response = await http.post(
      Uri.parse("https://aamras.com/dummy/EmployeeDetails.json"),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(<String, dynamic>{
        "" : "",
      }),
    );


    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      debugPrint(response.body.toString());
      return EmployeesModel.fromJson(jsonDecode(response.body)).employees!.toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Something went wrong! please try again');
    }
  }
}