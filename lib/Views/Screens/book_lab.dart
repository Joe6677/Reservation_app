import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_school_system/Models/tab_model.dart';
import 'package:smart_school_system/ViewModel/book_place.dart';
import 'package:smart_school_system/Views/widgets/drop_down_classes.dart';
import 'package:smart_school_system/Views/widgets/drop_down_intervals.dart';
import 'package:smart_school_system/Views/widgets/formField.dart';
import 'package:smart_school_system/Helpers/bottom_sheet_bar.dart';

// ignore: must_be_immutable
class BookLab extends StatelessWidget {
  BookLab({super.key, required this.item});
  TabModel item;
  final formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController classcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<BookPlace>(context);
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
          "Book a ${item.type}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formkey,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Formfield(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  TimeSlotDropdown(),
                  SizedBox(height: 20),
                  Text(
                    "Class Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  ClassSlotDropdown(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    submit(context, p: p);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
    );
  }

  void submit(BuildContext context, {required BookPlace p}) {
    if (formkey.currentState!.validate()) {
      p.addSession(item);
      Navigator.pop(context);
      showSnackBar(context, "${item.type} Booked Successfully");
    }
  }
}
