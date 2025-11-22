import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/Tab_Model.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';

// ignore: must_be_immutable
class StudentLab extends StatelessWidget {
  StudentLab({super.key, required this.item});
  TabModel item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 110, 238),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(230),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 56, 110, 238),
          centerTitle: true,
          title: null,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                "Lab Details | $selection",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text("Lab Schedule", style: TextStyle(color: Colors.white)),
            ],
          ),
          elevation: 4,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 390,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Text(
                item.place,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  item.is_available == true
                      ? Icon(Icons.circle, size: 15, color: Colors.green)
                      : Icon(Icons.circle, size: 15, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    item.is_available == true ? "Available" : "Occupied",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: item.is_available == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              item.is_available == true
                  ? SizedBox()
                  : Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_sharp,
                              color: Colors.grey,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${item.from} AM -"
                              " ${item.to} AM",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.grey,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              item.instructor,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.people_outline,
                              color: Colors.grey,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              item.classname,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
