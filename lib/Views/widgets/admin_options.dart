import 'package:flutter/material.dart';

String? option;

// ignore: must_be_immutable
class AdminOption extends StatelessWidget {
  String command;
  IconData icon;
  AdminOption({super.key, required this.command, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 250,
      child: InkWell(
        onTap: () {
          option = command;
          if (option == "Add User") {
            Navigator.pushNamed(context, '/adduser');
          } else if (option == "Edit User") {
            Navigator.pushNamed(context, '/modifyusers');
          } else if (option == "Delete User") {
            Navigator.pushNamed(context, '/deleteuser');
          }
        },
        child: Card(
          elevation: 2,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFdbeafe),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: Color.fromARGB(255, 56, 110, 238),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  command,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
