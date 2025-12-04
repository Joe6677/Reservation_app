import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final supabase = Supabase.instance.client;

  Future createStudnts() async {
    await supabase.from('Students').insert({
      'std_id': "43d57b21-af8b-4b4c-9f13-1c3283c289e5",
      'std_name': "Yousef Hesham",
      'std_email': "yousefhesham2468@gmail.com",
      'std_password': "Yousef1911##**",
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
}
