import 'package:flutter/material.dart';
import 'package:smart_school_system/Helpers/bottom_sheet_bar.dart';
import 'package:smart_school_system/RegX/regX.dart';
import 'package:smart_school_system/Services/database_service.dart';
import 'package:smart_school_system/Views/widgets/formField.dart';

// ignore: must_be_immutable
class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController classController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selected = "student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text('Add User', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 56, 110, 238),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
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
                    borderColor: Color.fromARGB(255, 56, 110, 238),
                    isPassword: false,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Formfield(
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
                    borderColor: Color.fromARGB(255, 56, 110, 238),
                    isPassword: false,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Formfield(
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
                    borderColor: Color.fromARGB(255, 56, 110, 238),
                  ),
                  SizedBox(height: 20),
                  selected == "student"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Class",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
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
                              borderColor: Color.fromARGB(255, 56, 110, 238),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Color.fromARGB(255, 56, 110, 238),
                            value: "student",
                            groupValue: selected,
                            onChanged: (v) => setState(() => selected = v!),
                          ),
                          Text("Student", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(width: 50),
                      Row(
                        children: [
                          Radio(
                            activeColor: Color.fromARGB(255, 56, 110, 238),
                            value: "instructor",
                            groupValue: selected,
                            onChanged: (v) => setState(() => selected = v!),
                          ),
                          Text("Instructor", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        submit(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 56, 110, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Add User",
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
      ),
    );
  }

  void submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      selected == "student"
          ? DatabaseService().addStudent(
              email: emailController.text,
              password: passwordController.text,
              username: nameController.text,
              classId: classController.text,
            )
          : DatabaseService().addInstructor(
              email: emailController.text,
              password: passwordController.text,
              fullName: nameController.text,
            );
      showSnackBar(
        context,
        "User added successfully",
        backgroundColor: Color.fromARGB(255, 56, 110, 238),
      );
      Navigator.pop(context);
    }
  }
}
