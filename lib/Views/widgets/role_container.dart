import 'package:flutter/material.dart';

String? selection;

// ignore: must_be_immutable, camel_case_types
class Role_Container extends StatelessWidget {
  Role_Container({super.key, required this.role, required this.icon});
  String role;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 350,
      child: InkWell(
        onTap: () {
          selection = role;
          Navigator.pushNamed(context, '/signin');
        },
        child: Card(
          elevation: 4,
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
                  role,
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
