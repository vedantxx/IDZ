import 'package:flutter/material.dart';
import 'package:idz_reg/database/MyDatabaseHelper.dart';
import 'package:idz_reg/database/database.dart';
import 'package:idz_reg/screens/landing_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? selectedId = -1;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("IDZ Reg"),
      // ),
      body: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            // color: Colors.redAccent,
                            height: MediaQuery.of(context).size.height * 0.199,
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: Image.asset(
                                "assets/logoidz.png",fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48,),
                        TextFormField(
                          controller: textEditingController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            // hintText: "Password",
                            hintMaxLines: 1,

                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            // alignLabelWithHint: false,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            filled: true,
                            contentPadding:
                            EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                            labelText: "Username",
                            labelStyle: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                        ),
                        const SizedBox(height: 32,),
                        Container(
                          height: 48,
                          child: TextFormField(
                            autofocus: true,
                            controller: passwordTextEditingController,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              // hintText: "Password",
                              hintMaxLines: 1,
                              // alignLabelWithHint: false,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              filled: true,
                              contentPadding:
                              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.black54
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48,),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: ()async{
                              if(selectedId == -1)
                              {
                                if (textEditingController.text != '' &&
                                    passwordTextEditingController.text != '') {
                                  await MyDatabaseHelper.instance.add(MyDatabase(
                                      name: textEditingController.text,
                                      password: passwordTextEditingController.text));
                                  setState(() {
                                    textEditingController.clear();
                                    passwordTextEditingController.clear();
                                  });
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyLandingPage()));
                                } else {
                                  debugPrint("Fill all details");
                                }
                              }
                              else {
                                await MyDatabaseHelper.instance.update(MyDatabase(
                                  id: selectedId,
                                  name: textEditingController.text,
                                  password: passwordTextEditingController.text,
                                ));
                                setState(() {
                                  textEditingController.clear();
                                  passwordTextEditingController.clear();
                                  selectedId = -1;
                                });
                              }
                            },
                            child: const Text("Next"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.brown
                            ),
                          ),
                        ),
                        const SizedBox(height: 48,),
                        // Expanded(
                        //   child: FutureBuilder<List<MyDatabase>>(
                        //     future: MyDatabaseHelper.instance.getDatabase(),
                        //     builder: (BuildContext context, AsyncSnapshot<List<MyDatabase>> snapshot){
                        //       if(!snapshot.hasData) {
                        //         return const Center(
                        //           child: Text("Loading..."),
                        //         );
                        //       }
                        //       return snapshot.data!.isEmpty ? const Center(
                        //         child: Text("No record"),
                        //       ) : ListView(
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         children: snapshot.data!.map((index) {
                        //           return Center(
                        //             child: Card(
                        //               color: selectedId == index.id ? Colors.white70 : Colors.white,
                        //               child: ListTile(
                        //                 title: Text(index.name.toString()),
                        //                 onTap: (){
                        //                   setState((){
                        //                     if(selectedId == -1) {
                        //                       passwordTextEditingController.text = index.password!;
                        //                       textEditingController.text = index.name!;
                        //                       selectedId = index.id;
                        //                     }
                        //                     else {
                        //                       textEditingController.text = '';
                        //                       passwordTextEditingController.text = '';
                        //                       selectedId = -1;
                        //                     }
                        //                   });
                        //                 },
                        //                 onLongPress: (){
                        //                   setState((){
                        //                     MyDatabaseHelper.instance.remove(index.id!);
                        //                   });
                        //                 },
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //       );
                        //   },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
