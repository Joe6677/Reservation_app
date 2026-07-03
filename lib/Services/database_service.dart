import 'package:flutter/material.dart';
import 'package:smart_school_system/Helpers/bottom_sheet_bar.dart';
import 'package:smart_school_system/Models/bookingModel.dart';
import 'package:smart_school_system/Views/widgets/drop_down_intervals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final supabase = Supabase.instance.client;

  Future createStudnts() async {
    await supabase.from('Students').insert({
      'std_id': "30d95f02-f7fd-4a87-ae68-425c4b199200",
      'std_name': "Abdo",
      'std_email': "abdo3112006mam@gmail.com",
      'std_password': "AO2006",
      'class_id': "5A",
    });
  }

  Future createInstructors() async {
    await supabase.from('Instructors').insert({
      'ins_id': "494ee710-9a43-4fb1-b6f8-bc010f204b8f",
      'ins_name': "Omar Osama",
      'ins_email': "omar06osama@gmail.com",
      'ins_password': "Omar1010#",
    });
  }

  Future createAdmin() async {
    await supabase.from('Admins').insert({
      'admin_id': "124d8ab3-f222-4abb-9911-6c3843729140",
      'admin_name': "Basma Ahmed",
      'admin_email': "admin123@gmail.com",
      'admin_password': "Admin123#",
    });
  }

  Future createClass() async {
    await supabase.from('Classes').insert([
      {'class_id': "11", 'class_name': "5A"},
      {'class_id': "12", 'class_name': "5B"},
    ]);
  }

  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> instructors = [];

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    final response = await Supabase.instance.client.from('Students').select();
    students = List<Map<String, dynamic>>.from(response);
    return students;
  }

  Future<List<Map<String, dynamic>>> fetchInstructors() async {
    final response = await Supabase.instance.client
        .from('Instructors')
        .select();
    instructors = List<Map<String, dynamic>>.from(response);
    return instructors;
  }

  Future<void> addStudent({
    required String email,
    required String password,
    required String username,
    required String classId,
  }) async {
    final authRes = await supabase.auth.signUp(
      email: email.trim(),
      password: password.trim(),
    );

    final String userId = authRes.user!.id;

    await supabase.from('Students').insert({
      'std_id': userId,
      'std_name': username,
      'std_email': email,
      'std_password': password,
      'class_id': classId,
    });
  }

  Future<void> addInstructor({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final authRes = await supabase.auth.signUp(
      email: email.trim(),
      password: password.trim(),
    );

    final String userId = authRes.user!.id;

    await supabase.from('Instructors').insert({
      'ins_id': userId,
      'ins_name': fullName,
      'ins_email': email,
      'ins_password': password,
    });
  }

  Future<void> updateStudent({
    required String userId,
    required String fullName,
    required String classId,
  }) async {
    await supabase
        .from('Students')
        .update({'std_name': fullName, 'class_id': classId})
        .eq('std_id', userId);
  }

  Future<void> updateInstructor({
    required String userId,
    required String fullName,
  }) async {
    await supabase
        .from('Instructors')
        .update({'ins_name': fullName})
        .eq('ins_id', userId);
  }

  Future<Map<String, dynamic>> loadInstructor(String userId) async {
    final response = await Supabase.instance.client
        .from('Instructors')
        .select()
        .eq('ins_id', userId)
        .single();
    return response;
  }

  Future<Map<String, dynamic>> loadStudent(String userId) async {
    final response = await Supabase.instance.client
        .from('Students')
        .select()
        .eq('std_id', userId)
        .single();
    return response;
  }

  Future<void> deleteStudent(String studentId) async {
    await supabase.from('Students').delete().match({'std_id': studentId});
  }

  Future<void> deleteInstructor(String InstructorId) async {
    await supabase.from('Instructors').delete().match({'ins_id': InstructorId});
  }

  Future<List<BookingModel>> fetchBookings() async {
    final data = await supabase
        .from('Booking')
        .select('* , Places(place_type) , Instructors(ins_name)')
        .order('book_id', ascending: true);

    return data.map<BookingModel>((e) => BookingModel.fromMap(e)).toList();
  }

  Future<bool> classExists(String classId) async {
    final response = await Supabase.instance.client
        .from('Classes')
        .select('class_id')
        .eq('class_id', classId)
        .maybeSingle();
    return response != null;
  }

  Future<void> confirmBooking(
    GlobalKey<FormState> formkey,
    GlobalKey<TimeSlotDropdownState> timeSlotKey,
    BuildContext context,
    TextEditingController classcontroller,
    String day,
    String place,
  ) async {
    if (!formkey.currentState!.validate()) return;

    final slot = timeSlotKey.currentState?.selected;
    if (slot == null) {
      showSnackBar(
        context,
        "Please choose a time slot",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (!await classExists(classcontroller.text.trim())) {
      showSnackBar(
        context,
        "Class does not exist",
        backgroundColor: Colors.red,
      );
      return;
    }

    final userId = Supabase.instance.client.auth.currentUser!.id;

    try {
      await Supabase.instance.client.from('Booking').insert({
        'ins_id': userId,
        'class_id': classcontroller.text.trim(),
        'place_id': place,
        'day': day,
        '_from': slot.from,
        '_to': slot.to,
      });

      showSnackBar(
        context,
        "Booked Successfully",
        backgroundColor: Color.fromARGB(255, 56, 110, 238),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      showSnackBar(context, "Booking failed: $e", backgroundColor: Colors.red);
    }
  }
}
