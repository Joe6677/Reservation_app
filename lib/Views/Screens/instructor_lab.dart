import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/bookingModel.dart';
import 'package:smart_school_system/Models/placesModel.dart';
import 'package:smart_school_system/Services/database_service.dart';
import 'package:smart_school_system/Views/Screens/book_lab.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';

// ignore: must_be_immutable
class InstructorLab extends StatefulWidget {
  final PlacesModel item;
  final String day;
  String placeName;
  String placeType;
  BookingModel booking = BookingModel(
    bookId: 0,
    instructor: '',
    classname: '',
    place: '',
    from: '',
    to: '',
    placeType: '',
    day: '',
    insName: '',
  );

  InstructorLab({
    super.key,
    required this.item,
    required this.day,
    required this.placeName,
    required this.placeType,
  });

  @override
  State<InstructorLab> createState() => _InstructorLabState();
}

class _InstructorLabState extends State<InstructorLab> {
  List<BookingModel> allItems = [];
  List<BookingModel> filteredSessions = [];
  bool progress = true;
  Future<void> loadBookings() async {
    allItems = await DatabaseService().fetchBookings();
    progress = false;
    filteration(widget.day, widget.placeName);

    setState(() {});
  }

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
      backgroundColor: const Color.fromARGB(255, 56, 110, 238),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 110, 238),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          centerTitle: true,
          title: Text(
            "${widget.item.place_type} Schedule",
            style: const TextStyle(
              fontSize: 30,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: progress
          ? const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 250),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            )
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: filteredSessions.isEmpty
                          ? const Center(
                              child: Text(
                                "No Sessions Today",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredSessions.length,

                              itemBuilder: (context, index) {
                                widget.booking = filteredSessions[index];

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff3f4f6),
                                    borderRadius: BorderRadius.circular(15),
                                    border: const Border(
                                      left: BorderSide(
                                        color: Color.fromARGB(255, 3, 132, 244),
                                        width: 4,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      widget.booking.insName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${widget.booking.from} - ${widget.booking.to}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Text(
                                      widget.booking.classname,
                                      style: const TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          56,
                                          110,
                                          238,
                                        ),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 10),
                    selection == "Instructor"
                        ? SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookLab(
                                      item: widget.booking,
                                      placeName: widget.placeName,
                                      placeType: widget.placeType,
                                      day: widget.day,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  56,
                                  110,
                                  238,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Book ${widget.item.place_type}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
    );
  }
}
