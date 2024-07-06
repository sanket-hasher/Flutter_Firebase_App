import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_firebase/pages/student.dart';
import 'package:flutter_firebase/services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController roll = TextEditingController();

  Stream<QuerySnapshot>? studentStream;

  void getontheLoad() async {
    studentStream = await DatabaseMethods().getStudentDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheLoad();
  }

  Widget allStudentDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: studentStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Center(child: Text("Something went wrong"));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print("No data available: ${snapshot.data}");
          return Center(child: Text("No data available"));
        } else {
          print("Data fetched: ${snapshot.data!.docs.length} documents");
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 160, 218, 122),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            name.text = ds['Name'];
                            age.text = ds['Age'];
                            location.text = ds['Location'];
                            roll.text = ds['Roll'];
                            EditStudentDetails(ds['Id']);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 18,
                          height: 2,
                        ),
                        GestureDetector(
                          child: Icon(Icons.delete, color: Colors.red),
                          onTap: () {
                            DatabaseMethods().deleteStudentDetails(ds['Id']);
                          },
                        )
                      ],
                    ),
                    Text(
                      "Name : " + ds['Name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "Location : " + ds['Location'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "Roll Number : " + ds['Roll'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "Age : " + ds['Age'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Flutter",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              Text("Firebase",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow))
            ],
          ),
        ),
        body: Stack(children: [
          Column(
            children: [Expanded(child: allStudentDetails())],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Student()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(
                    255, 122, 219, 198), // Button background color
                foregroundColor: Colors.deepOrange, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Border radius
                ),
              ),
              child: Text(
                "Add Details",
                style: TextStyle(fontSize: 26, color: Colors.deepOrange),
              ),
            ),
          ),
        ]));
  }

  Future EditStudentDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Edit",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Text("Details",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                  ],
                ),
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Name",
                    ),
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing as needed
                Text(
                  "Age",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    controller: age,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Age",
                    ),
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing as needed
                Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    controller: location,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter location",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Roll No",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ), // Adjust spacing as needed
                Container(
                  padding: EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    controller: roll,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Roll",
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfoMap = {
                          "Name": name.text,
                          "Age": age.text,
                          "Id": id,
                          "Location": location.text,
                          "Roll": roll.text
                        };
                        return await DatabaseMethods()
                            .updateStudentDetails(id, updateInfoMap)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Updated Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 219, 219, 137), // Button background color
                        foregroundColor:
                            Colors.deepOrange, // Button text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Border radius
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 211, 126, 16)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )));
}
