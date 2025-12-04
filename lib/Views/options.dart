import 'package:flutter/material.dart';
import 'package:smart_school_system/Views/widgets/admin_options.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminOption(icon: Icons.person_add_alt_1, command: "Add User"),
              AdminOption(icon: Icons.edit_note, command: "Edit User"),
              AdminOption(icon: Icons.delete_forever, command: "Delete User"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
