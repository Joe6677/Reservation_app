// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Formfield extends StatefulWidget {
  String lable;
  bool? is_password;
  bool is_obsecure;
  String? Function(String?) validator;
  TextEditingController controller = TextEditingController();
  IconData icon;

  Formfield({
    super.key,
    required this.lable,
    this.is_password,
    this.is_obsecure = false,
    required this.validator,
    required this.controller,
    required this.icon,
  });

  @override
  State<Formfield> createState() => _FormfieldState();
}

class _FormfieldState extends State<Formfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.is_obsecure,
      style: TextStyle(color: Color(0xFF0a2f50), fontWeight: FontWeight.bold),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        fillColor: Color(0xfff3f4f6),
        hintText: widget.lable,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        suffixIcon: widget.is_password == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.is_obsecure = !widget.is_obsecure;
                  });
                },
                icon: widget.is_obsecure == true
                    ? Icon(Icons.visibility_off_sharp)
                    : Icon(Icons.visibility),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 56, 110, 238),
            width: 2,
          ),
        ),
      ),
    );
  }
}
