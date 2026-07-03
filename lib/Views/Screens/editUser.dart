import 'package:flutter/material.dart';
import 'package:smart_school_system/Helpers/bottom_sheet_bar.dart';
import 'package:smart_school_system/RegX/regX.dart';
import 'package:smart_school_system/Services/database_service.dart';
import 'package:smart_school_system/Views/widgets/formField.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  final String userid;
  final String type;
  const EditUser({super.key, required this.userid, required this.type});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  Map<String, dynamic>? originalUser;
  bool isChanged = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkIfChanged);
    classController.addListener(checkIfChanged);

    loadAndSetUser();
  }

  void checkIfChanged() {
    bool changed = false;

    if (widget.type == "student") {
      changed =
          nameController.text.trim() != (originalUser!['std_name'] ?? '') ||
          classController.text.trim() != (originalUser!['class_id'] ?? '');
    } else {
      changed = nameController.text.trim() != (originalUser!['ins_name'] ?? '');
    }

    if (changed != isChanged) {
      setState(() {
        isChanged = changed;
      });
    }
  }

  Future<void> loadAndSetUser() async {
    final Map<String, dynamic> user = (widget.type == "student")
        ? await DatabaseService().loadStudent(widget.userid)
        : await DatabaseService().loadInstructor(widget.userid);
    originalUser = user;
    setState(() {
      if (widget.type == "student") {
        nameController.text = user['std_name']?.toString() ?? '';
        emailController.text = user['std_email']?.toString() ?? '';
        classController.text = user['class_id']?.toString() ?? '';
        passwordController.text = user['std_password']?.toString() ?? '';
      } else {
        nameController.text = user['ins_name']?.toString() ?? '';
        emailController.text = user['ins_email']?.toString() ?? '';
        passwordController.text = user['ins_password']?.toString() ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 110, 238),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Name",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Formfield(
                  lable: "Enter user name",
                  icon: Icons.person,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the user name';
                    }
                    return null;
                  },
                  borderColor: const Color.fromARGB(255, 56, 110, 238),
                  isPassword: false,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Formfield(
                  enabled: false,
                  lable: "Enter user email",
                  icon: Icons.email,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!isvalidemail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  borderColor: const Color.fromARGB(255, 56, 110, 238),
                  isPassword: false,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Formfield(
                  enabled: false,
                  lable: "Enter user password",
                  icon: Icons.lock,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 5) {
                      return "Password must be at least 5 characters long";
                    }
                    return null;
                  },
                  borderColor: const Color.fromARGB(255, 56, 110, 238),
                ),
                const SizedBox(height: 20),
                if (widget.type == "student") ...[
                  const Text(
                    "Class",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Formfield(
                    lable: "Enter student class",
                    icon: Icons.bookmark,
                    controller: classController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter student class";
                      }
                      return null;
                    },
                    borderColor: const Color.fromARGB(255, 56, 110, 238),
                  ),
                  const SizedBox(height: 20),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isChanged ? () => submit(context) : null,
                    style: TextButton.styleFrom(
                      backgroundColor: isChanged
                          ? Color.fromARGB(255, 56, 110, 238)
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Confirm Editing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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

  void submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (widget.type == "student") {
        await DatabaseService().updateStudent(
          fullName: nameController.text.trim(),
          classId: classController.text.trim(),
          userId: widget.userid,
        );
      } else {
        await DatabaseService().updateInstructor(
          fullName: nameController.text.trim(),
          userId: widget.userid.trim(),
        );
      }
    }
    showSnackBar(
      context,
      "User updated successfully",
      backgroundColor: const Color.fromARGB(255, 56, 110, 238),
    );
    Navigator.pop(context, true);
  }
}
