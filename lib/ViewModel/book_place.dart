import 'package:flutter/foundation.dart';
import 'package:smart_school_system/Models/tab_model.dart';

class BookPlace extends ChangeNotifier {
  List<TabModel> filteredSessions = [];
  void filteration(String day, String place) {
    filteredSessions = allItems
        .where((m) => m.date == day && m.place == place)
        .toList();
  }

  void addSession(TabModel session) {
    filteredSessions.add(session);
    notifyListeners();
  }
}
