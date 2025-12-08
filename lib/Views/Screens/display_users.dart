import 'package:flutter/material.dart';
import 'package:smart_school_system/Services/database_service.dart';

class DisplayUsers extends StatefulWidget {
  const DisplayUsers({super.key});

  @override
  State<DisplayUsers> createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {
  final DatabaseService databaseService = DatabaseService();

  List<Map<String, dynamic>> instructors = [];
  List<Map<String, dynamic>> students = [];
  bool loading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final insResult = await databaseService.fetchInstructors();
      final stdResult = await databaseService.fetchStudents();
      setState(() {
        instructors = insResult;
        students = stdResult;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 56, 110, 238),
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: $error'),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: loadData, child: const Text('Retry')),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructors",
            style: TextStyle(
              color: const Color.fromARGB(255, 56, 110, 238),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: instructors.isEmpty
                ? const Center(child: Text('No instructors found'))
                : ListView.builder(
                    itemCount: instructors.length,
                    itemBuilder: (context, index) {
                      final ins = instructors[index];
                      final name = ins['ins_name']?.toString() ?? 'No name';
                      final subtitle =
                          ins['ins_email']?.toString() ?? 'No email';
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFdbeafe),
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 56, 110, 238),
                          ),
                        ),
                        title: Text(name),
                        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            "Students",
            style: TextStyle(
              color: const Color.fromARGB(255, 56, 110, 238),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: students.isEmpty
                ? const Center(child: Text('No students found'))
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final s = students[index];
                      final email = s['std_email']?.toString() ?? "No email";
                      final name = s['std_name']?.toString() ?? 'No name';
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFdbeafe),
                          child: Icon(
                            Icons.school,
                            color: Color.fromARGB(255, 56, 110, 238),
                          ),
                        ),
                        title: name.isNotEmpty ? Text(name) : null,
                        subtitle: Text(email),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
