import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_school_system/Models/tab_model.dart';
import 'package:smart_school_system/ViewModel/book_place.dart';
import 'package:smart_school_system/Views/instructor_lab.dart';
import 'package:smart_school_system/Views/student_lab.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';

// ignore: must_be_immutable
class Lab extends StatefulWidget {
  Lab({
    super.key,
    required this.labname,
    required this.from,
    required this.to,
    required this.instructor,
    required this.classname,
    required this.t,
    required this.item,
  });
  TabModel item;
  String labname;
  String from;
  String to;
  String instructor;
  String classname;
  TabModel t;

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<BookPlace>(context);
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        height: selection == "Student" ? 150 : 231,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.labname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        widget.item.isAvailable == true
                            ? Icon(Icons.circle, size: 10, color: Colors.green)
                            : Icon(Icons.circle, size: 10, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          widget.item.isAvailable == true
                              ? "Vacant"
                              : "Occupied",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: widget.item.isAvailable == true
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                selection == "Student"
                    ? SizedBox(height: 0)
                    : Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF4c5664),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${widget.from} - ${widget.to}",
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
                                widget.instructor,
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
                                "Class : ${widget.classname}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 56, 110, 238),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      p.filteration(widget.t.date, widget.t.place);
                      if (selection == "Student") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentLab(item: widget.t),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstructorLab(item: widget.t),
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
