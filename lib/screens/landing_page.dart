import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../apis/idz_test_api.dart';
import '../database/MyDatabaseHelper.dart';
import '../database/database.dart';
import '../models/employees_model.dart';
import '../providers/employes_api_provider.dart';

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({Key? key}) : super(key: key);

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  // TabController tabController = TabController(length: 2, vsync: );



  @override
  Widget build(BuildContext context) {
    final provider =  Provider.of<EmployeesApiProvider>(context);
    // final currencyDataSource = provider.currencyDataSource;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 48,
          title: const Text(
            "IDZ",
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book_sharp)),
              Tab(icon: Icon(Icons.network_check_sharp)),
              // Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/bg.jpg",fit: BoxFit.cover,),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            Expanded(
                              child: FutureBuilder<List<MyDatabase>>(
                                future: MyDatabaseHelper.instance.getDatabase(),
                                builder: (BuildContext context, AsyncSnapshot<List<MyDatabase>> snapshot){
                                  if(!snapshot.hasData) {
                                    return const Center(
                                      child: Text("Loading..."),
                                    );
                                  }
                                  return snapshot.data!.isEmpty ? const Center(
                                    child: Text("No record"),
                                  ) : ListView(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    children: snapshot.data!.map((index) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        // width: MediaQuery.of(context).size.width * 0.6,
                                        child: Card(
                                          // color: selectedId == index.id ? Colors.white70 : Colors.white,
                                          child: ListTile(
                                            title: Text("Username: ${index.name.toString()}"),
                                            trailing: Container(
                                              // color: Colors.redAccent,
                                              height: MediaQuery.of(context).size.height * 0.04,
                                              width: MediaQuery.of(context).size.width * 0.1,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(48),
                                                child: Image.asset(
                                                  "assets/logoidz.png",fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            subtitle: Text("Email: ${index.email.toString()}, DOB: ${index.dob.toString().substring(0,10)}"),
                                            // onTap: (){
                                            //   setState((){
                                            //     if(selectedId == -1) {
                                            //       passwordTextEditingController.text = index.password!;
                                            //       textEditingController.text = index.name!;
                                            //       selectedId = index.id;
                                            //     }
                                            //     else {
                                            //       textEditingController.text = '';
                                            //       passwordTextEditingController.text = '';
                                            //       selectedId = -1;
                                            //     }
                                            //   });
                                            // },
                                            onLongPress: (){
                                              setState((){
                                                MyDatabaseHelper.instance.remove(index.id!);
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/bg.jpg",fit: BoxFit.cover,),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            Expanded(
                              child: FutureBuilder<List<Employees>>(
                                future: IDZ.getEmployees(),
                                builder: (BuildContext context, AsyncSnapshot<List<Employees>> snapshot){
                                  if(!snapshot.hasData) {
                                    return const Center(
                                      child: Text("Loading..."),
                                    );
                                  }
                                  return snapshot.data!.isEmpty ? const Center(
                                    child: Text("No record"),
                                  ) : ListView(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    children: snapshot.data!.map((index) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        // width: MediaQuery.of(context).size.width * 0.6,
                                        child: Card(
                                          // color: selectedId == index.id ? Colors.white70 : Colors.white,
                                          child: ListTile(
                                            title: Text("Name: ${index.name.toString()}"),
                                            trailing: Container(
                                              // color: Colors.redAccent,
                                              height: MediaQuery.of(context).size.height * 0.04,
                                              width: MediaQuery.of(context).size.width * 0.1,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(48),
                                                child: Image.asset(
                                                  "assets/logoidz.png",fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            subtitle: Text("Salary: ${index.salary.toString()} , Age: ${index.age.toString()}"),
                                            // onTap: (){
                                            //   setState((){
                                            //     if(selectedId == -1) {
                                            //       passwordTextEditingController.text = index.password!;
                                            //       textEditingController.text = index.name!;
                                            //       selectedId = index.id;
                                            //     }
                                            //     else {
                                            //       textEditingController.text = '';
                                            //       passwordTextEditingController.text = '';
                                            //       selectedId = -1;
                                            //     }
                                            //   });
                                            // },
                                            // onLongPress: (){
                                            //   setState((){
                                            //     MyDatabaseHelper.instance.remove(index.name);
                                            //   });
                                            // },
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Icon(Icons.camera_alt),
            // Icon(Icons.grade),
            // Icon(Icons.email),
          ],
        ),
        // body:
      ),
    );
  }
}
