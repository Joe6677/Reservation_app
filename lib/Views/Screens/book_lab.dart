import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/bookingModel.dart';
import 'package:smart_school_system/Services/database_service.dart';
import 'package:smart_school_system/Views/widgets/drop_down_intervals.dart';
import 'package:smart_school_system/Views/widgets/formField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class BookLab extends StatefulWidget {
  BookLab({
    super.key,
    required this.item,
    required this.placeType,
    required this.placeName,
    required this.day,
  });
  BookingModel item;
  String placeName;
  String placeType;
  String day;
  @override
  State<BookLab> createState() => _BookLabState();
}

class _BookLabState extends State<BookLab> {
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  List<BookingModel> allItems = [];
  final timeSlotKey = GlobalKey<TimeSlotDropdownState>();

  TextEditingController namecontroller = TextEditingController(text: "");

  TextEditingController classcontroller = TextEditingController();
  Future<void> loadInfo() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    allItems = await DatabaseService().fetchBookings();

    final Map<String, dynamic> user = await DatabaseService().loadInstructor(
      userId,
    );
    setState(() {
      namecontroller.text = user['ins_name']?.toString() ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 110, 238),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 56, 110, 238),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        titleSpacing: 0,
        title: Text(
          "Book a ${widget.placeType}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formkey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 400,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Instructor Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Formfield(
                        enabled: false,
                        borderColor: Colors.transparent,
                        controller: namecontroller,
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Instructor Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Select Time Slot",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      TimeSlotDropdown(
                        key: timeSlotKey,
                        bookings: allItems,
                        day: widget.item.day,
                        placeName: widget.item.place,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Class ID",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Formfield(
                        controller: classcontroller,
                        icon: Icons.class_,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Class Name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        DatabaseService().confirmBooking(
                          formkey,
                          timeSlotKey,
                          context,
                          classcontroller,
                          widget.day,
                          widget.placeName,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFF3558d4),
                      ),
                      child: Text(
                        "Confirm Booking",
                        style: TextStyle(color: Colors.white),
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
