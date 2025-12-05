import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/tab_model.dart';
import 'package:smart_school_system/Views/Screens/book_lab.dart';

// ignore: must_be_immutable
class InstructorLab extends StatelessWidget {
  InstructorLab({super.key, required this.item});
  TabModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 110, 238),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(280),
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
                "${item.type} Schedule",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          elevation: 4,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 450,
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
            children: [
              item.type == "Class"
                  ? Row(
                      children: [
                        Text(
                          "${item.type} ${item.place}",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      item.place,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: item.isAvailable == true ? Colors.green : Colors.red,
                    size: 10,
                  ),
                  SizedBox(width: 5),
                  Text(
                    item.isAvailable == true ? "Vacant" : "Occupied",
                    style: item.isAvailable == true
                        ? TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )
                        : TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookLab(item: item),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color.fromARGB(255, 56, 110, 238),
                  ),
                  child: Text(
                    "Book ${item.type}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFFf3f4f6),
                  ),
                  child: Text(
                    "Scan Attendance",
                    style: TextStyle(color: Color.fromARGB(255, 56, 110, 238)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
