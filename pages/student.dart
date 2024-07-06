import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController roll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Student",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            Text("Form",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow))
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 20), // Adjust spacing as needed
            Text(
              "Roll No ",
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
                controller: roll,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Roll Number",
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String id = randomNumeric(2);
                    Map<String, dynamic> studentInfoMap = {
                      "Name": name.text,
                      "Age": age.text,
                      "Id": id,
                      "Location": location.text,
                      "Roll": roll.text
                    };
                    await DatabaseMethods()
                        .addStudentDetails(studentInfoMap, id).then((value) {
                         Fluttertoast.showToast(
                        msg: "Added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.lightBlueAccent, // Button background color
                    foregroundColor: Colors.deepOrange, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Border radius
                    ),
                  ),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 70, 145, 214)),
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
