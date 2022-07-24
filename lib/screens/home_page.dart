import 'package:flutter/material.dart';
import 'package:idz_reg/database/MyDatabaseHelper.dart';
import 'package:idz_reg/database/database.dart';
import 'package:idz_reg/screens/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../providers/date_selector_provider.dart';
import 'date_pick_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? selectedId = -1;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController yearTextEditingController = TextEditingController();
  TextEditingController monthTextEditingController = TextEditingController();
  TextEditingController dayTextEditingController = TextEditingController();


  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }


  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textEditingController.dispose();
    emailTextEditingController.dispose();
    yearTextEditingController.dispose();
    monthTextEditingController.dispose();
    dayTextEditingController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final provider =  Provider.of<DateSelectorProvider>(context,listen: false);
    yearTextEditingController = provider.yc;
    monthTextEditingController = provider.mc;
    dayTextEditingController = provider.dc;
    _selectedDate = provider.date!;
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 148,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            // color: Colors.redAccent,
                            height: MediaQuery.of(context).size.height * 0.199/2,
                            width: MediaQuery.of(context).size.width * 0.44/2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: Image.asset(
                                "assets/logoidz.png",fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Text("Welcome User !!",style: TextStyle(
                          fontSize: 32,
                          color: Colors.brown
                        ),),
                        const Text("Please enter your details",style: TextStyle(
                            fontSize: 16,
                            color: Colors.brown
                        ),),
                        const SizedBox(height: 32,),
                        Container(
                          height: 48,
                          child: TextFormField(
                            controller: textEditingController,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                            // autofocus: true,
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
                        ),
                        const SizedBox(height: 32,),

                        // Container(
                        //   height: MediaQuery.of(context).size.height,
                        //   child: Stack(
                        //     children: <Widget>[
                        //       Positioned(
                        //         left: 0,
                        //         right: 0,
                        //         top: 0,
                        //         height: 80,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           mainAxisSize: MainAxisSize.min,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: <Widget>[
                        //             Text('Selected date: $_selectedDate'),
                        //             // Text('Selected date count: $_dateCount'),
                        //             Text('Selected range: $_range'),
                        //             // Text('Selected ranges count: $_rangeCount')
                        //           ],
                        //         ),
                        //       ),
                        //       Positioned(
                        //         left: 0,
                        //         top: 80,
                        //         right: 0,
                        //         bottom: 0,
                        //         child: SfDateRangePicker(
                        //           onSelectionChanged: _onSelectionChanged,
                        //           selectionMode: DateRangePickerSelectionMode.range,
                        //           initialSelectedRange: PickerDateRange(
                        //               DateTime.now().subtract(const Duration(days: 4)),
                        //               DateTime.now().add(const Duration(days: 3))),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 32,),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width/4,
                                child: TextFormField(
                                  readOnly: true,
                                  // initialValue: provider.date,
                                  controller: yearTextEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select year';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DatePickScreen()));
                                  },
                                  // controller: textEditingController,
                                  // autofocus: true,
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
                                    labelText: "Year",
                                    labelStyle: TextStyle(
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 32,),
                              Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width/4,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: monthTextEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select month';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DatePickScreen()));
                                  },
                                  // controller: textEditingController,
                                  // autofocus: true,
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
                                    labelText: "Month",
                                    labelStyle: TextStyle(
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 32,),
                              Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width/4,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: dayTextEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select day';
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DatePickScreen()));
                                  },
                                  // controller: textEditingController,
                                  // autofocus: true,
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
                                    labelText: "Day",
                                    labelStyle: TextStyle(
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32,),

                        Container(
                          height: 48,
                          child: TextFormField(
                            // autofocus: true,
                            controller: emailTextEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintMaxLines: 1,
                              // alignLabelWithHint: false,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              filled: true,
                              contentPadding:
                              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              labelText: "Email",
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

                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                // if(selectedId == -1)
                                // {
                                  if (textEditingController.text != '' &&
                                      emailTextEditingController.text != '') {
                                    await MyDatabaseHelper.instance.add(MyDatabase(
                                      name: textEditingController.text,
                                      email: emailTextEditingController.text,
                                      dob: _selectedDate,
                                    ));
                                    setState(() {
                                      textEditingController.clear();
                                      emailTextEditingController.clear();
                                      yearTextEditingController.clear();
                                      monthTextEditingController.clear();
                                      dayTextEditingController.clear();
                                    });
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyLandingPage()));
                                  } else {
                                    debugPrint("Fill all details");
                                  }
                                // }
                                // else {
                                //   await MyDatabaseHelper.instance.update(MyDatabase(
                                //     id: selectedId,
                                //     name: textEditingController.text,
                                //     email: emailTextEditingController.text,
                                //   ));
                                //   setState(() {
                                //     textEditingController.clear();
                                //     emailTextEditingController.clear();
                                //     selectedId = -1;
                                //   });
                                // }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
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
