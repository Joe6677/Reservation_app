import 'package:flutter/material.dart';
import 'package:smart_school_system/Models/tab_model.dart';

// ignore: must_be_immutable
class StudentLab extends StatefulWidget {
  StudentLab({super.key, required this.item});
  TabModel item;

  @override
  State<StudentLab> createState() => _StudentLabState();
}

class _StudentLabState extends State<StudentLab> {
  @override
  void initState() {
    super.initState();
    setState(() {
      void filteration(String day, String place) {
        filteredSessions = allItems
            .where((m) => m.date == day && m.place == place)
            .toList();
      }

      filteration(widget.item.date, widget.item.place);
    });
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
                "Lab Schedule",
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
        height: 480,
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
                widget.item.place,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredSessions.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                          filteredSessions[index].instructor,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${filteredSessions[index].from} AM : ${filteredSessions[index].to} AM ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          filteredSessions[index].isAvailable
                              ? "Vacant"
                              : "Occupied",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: filteredSessions[index].isAvailable
                                ? Colors.green
                                : Colors.red,
                            fontSize: 15,
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
