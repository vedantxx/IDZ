import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String? dob;
  final String? email;
  final String? age;
  final String? salary;
  final int isNet;
  const DetailsScreen({Key? key,required this.name,required this.isNet, this.dob,this.email,this.age,this.salary}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
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
                  const SizedBox(height: 32,),
                  Text("${widget.name.toString()}",style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white
                  ),),
                  widget.isNet == 0 ?
                  Text("DOB: ${widget.dob.toString().substring(0,10)}",style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white70
                  ),) : Text("Age: ${widget.age.toString()}",style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white70
                  ),),
                  widget.isNet == 0 ?
                  Text("Email: ${widget.email.toString()}",style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white70
                  ),) :
                  Text("Salary: ${widget.salary.toString()}",style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white70
                  ),),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
