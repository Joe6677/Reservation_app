import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/bookingModel.dart';
import 'package:smart_school_system/Models/placesModel.dart';
import 'package:smart_school_system/Services/database_service.dart';

// ignore: must_be_immutable
class StudentLab extends StatefulWidget {
  StudentLab({super.key, required this.item, required this.day});
  PlacesModel item;
  String day;
  @override
  State<StudentLab> createState() => _StudentLabState();
}

class _StudentLabState extends State<StudentLab> {
  List<BookingModel> allItems = [];
  Future<void> loadBookings() async {
    allItems = await DatabaseService().fetchBookings();
    filteration(widget.day, widget.item.place_name);
    setState(() {});
  }

  List<BookingModel> filteredSessions = [];
  void filteration(String day, String place) {
    filteredSessions = allItems
        .where((m) => m.day == day && m.place == place)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

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
                "${widget.item.place_type} schedule",
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
        height: 570,
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
                widget.item.place_name,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredSessions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 3, 132, 244),
                            ),
                          ),
                          color: Color(0xFFf3f4f6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            filteredSessions[index].insName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${filteredSessions[index].from} - ${filteredSessions[index].to}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            filteredSessions[index].classname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 56, 110, 238),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
