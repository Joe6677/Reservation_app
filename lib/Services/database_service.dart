import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final supabase = Supabase.instance.client;

  Future createStudnts() async {
    await supabase.from('Students').insert({
      'std_id': "fedb0fb2-b0be-4a3c-b508-95c3863cd376",
      'std_name': "Steve Mohammed",
      'std_email': "stevemohammed@gmail.com",
      'std_password': "Steve2007#",
      'class_id': 11,
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
      'admin_id': "bb05af18-d3bd-4a11-bdb6-e981fdf3a96b",
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
}
