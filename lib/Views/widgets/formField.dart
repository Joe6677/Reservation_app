import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Formfield extends StatefulWidget {
  String lable;
  bool? isPassword;
  bool isObsecure;
  String? Function(String?) validator;
  TextEditingController controller = TextEditingController();
  IconData icon;
  bool enabled = true;
  Color borderColor;
  Formfield({
    super.key,
    this.lable = "",
    this.isPassword,
    this.isObsecure = false,
    required this.validator,
    this.enabled = true,
    required this.controller,
    required this.icon,
    this.borderColor = const Color.fromARGB(255, 56, 110, 238),
  });

  @override
  State<Formfield> createState() => _FormfieldState();
}

class _FormfieldState extends State<Formfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isObsecure,
      style: TextStyle(
        color: widget.enabled == true
            ? Colors.black
            : Color.fromARGB(255, 99, 99, 99),
        fontWeight: FontWeight.bold,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        fillColor: Color(0xfff3f4f6),
        hintText: widget.lable,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isObsecure = !widget.isObsecure;
                  });
                },
                icon: widget.isObsecure == true
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
          borderSide: BorderSide(color: widget.borderColor, width: 2),
        ),
      ),
    );
  }
}
