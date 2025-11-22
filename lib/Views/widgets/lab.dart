import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/Tab_Model.dart';
import 'package:smart_school_system/Views/instructor_lab.dart';
import 'package:smart_school_system/Views/student_lab.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';

// ignore: must_be_immutable
class Lab extends StatelessWidget {
  Lab({
    super.key,
    required this.labname,
    required this.from,
    required this.to,
    required this.instructor,
    required this.classname,
    required this.t,
  });
  String labname;
  String from;
  String to;
  String instructor;
  String classname;
  TabModel t;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        height: 231,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(width: 4, color: Color.fromARGB(255, 3, 132, 244)),
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labname,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, color: Color(0xFF4c5664)),
                    SizedBox(width: 10),
                    Text(
                      "$from : $to",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4c5664),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_outlined,
                      color: Color(0xFF4c5664),
                    ),
                    SizedBox(width: 10),
                    Text(
                      instructor,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4c5664),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.people_alt_sharp,
                      color: Color.fromARGB(255, 56, 110, 238),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Class : $classname",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 56, 110, 238),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (selection == "Student") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentLab(item: t),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstructorLab(item: t),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: Color.fromARGB(255, 211, 229, 255),
                    ),
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 56, 110, 238),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
