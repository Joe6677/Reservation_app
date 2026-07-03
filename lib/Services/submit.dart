import 'package:flutter/material.dart';
import 'package:smart_school_system/Helpers/bottom_sheet_bar.dart';
import 'package:smart_school_system/Views/widgets/role_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void submit(
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
  GlobalKey<FormState> formKey,
) async {
  final supabase = Supabase.instance.client;
  if (formKey.currentState!.validate()) {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on AuthException {
      return showSnackBar(
        context,
        "Email or Password is incorrect",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      return showSnackBar(
        context,
        "An unexpected error occurred: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    }
    final userId = supabase.auth.currentUser!.id;

    if (selection == "Student") {
      final student = await supabase
          .from('Students')
          .select('std_id')
          .eq('std_id', userId)
          .maybeSingle();

      if (student != null) {
        await showBlockingSheet(context);
        showSnackBar(
          context,
          "Login successful",
          backgroundColor: Color.fromARGB(255, 56, 110, 238),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        return;
      } else {
        return showSnackBar(
          context,
          "You are not a Student",
          backgroundColor: Colors.red,
        );
      }
    } else if (selection == "Instructor") {
      final instructor = await supabase
          .from('Instructors')
          .select('ins_id')
          .eq('ins_id', userId)
          .maybeSingle();
      if (instructor != null) {
        await showBlockingSheet(context);
        showSnackBar(
          context,
          "Login successful",
          backgroundColor: Color.fromARGB(255, 56, 110, 238),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        return;
      } else {
        return showSnackBar(
          context,
          "You are not an Instructor",
          backgroundColor: Colors.red,
        );
      }
    } else {
      final admin = await supabase
          .from('Admins')
          .select('admin_id')
          .eq('admin_id', userId)
          .maybeSingle();

      if (admin != null) {
        await showBlockingSheet(context);
        showSnackBar(
          context,
          "Login successful",
          backgroundColor: Color.fromARGB(255, 56, 110, 238),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/admin', (route) => false);
        return;
      } else {
        return showSnackBar(
          context,
          "You are not an Admin",
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
