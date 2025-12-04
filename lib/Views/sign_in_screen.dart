import 'package:flutter/material.dart';
import 'package:smart_school_system/RegX/regX.dart';
import 'package:smart_school_system/Services/submit.dart';
import 'package:smart_school_system/Views/widgets/formField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  SignIn({super.key});
  TextEditingController emailController = TextEditingController(
    text: 'yousefhesham2468@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: "Yousef1911##**",
  );
  final formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 110, 238),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(230),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 56, 110, 238),
          centerTitle: true,
          title: null,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                "I-Tech",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text("Let's get you in.", style: TextStyle(color: Colors.white)),
            ],
          ),
          elevation: 4,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 700,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Formfield(
                    icon: Icons.mail_outline_rounded,
                    controller: emailController,
                    isPassword: false,
                    lable: "your.email@example.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!isvalidemail(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 10),
                  Formfield(
                    icon: Icons.lock_outline_rounded,
                    isObsecure: true,
                    controller: passwordController,
                    isPassword: true,
                    lable: "Enter your password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 5) {
                        return "Password must be at least 8 characters long";
                      }
                      if (!isValidPassword(value)) {
                        return "Password must contain at least one uppercase letter, one number, and one special character";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        submit(
                          context,
                          emailController,
                          passwordController,
                          formKey,
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 56, 110, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Login",
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
}
