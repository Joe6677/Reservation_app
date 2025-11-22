import 'package:flutter/material.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';

class Role extends StatelessWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 56, 110, 238),
        title: Row(
          children: [
            Icon(Icons.supervisor_account, color: Colors.white, size: 27),
            SizedBox(width: 10),
            Text(
              "I-Tech",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: Size(0, 25),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, right: 190),
            child: Text(
              "Ready when you are!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Select Your Role",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Role_Container(icon: Icons.co_present, role: "Instructor"),
            SizedBox(height: 20),
            Role_Container(icon: Icons.school, role: "Student"),
          ],
        ),
      ),
    );
  }
}
