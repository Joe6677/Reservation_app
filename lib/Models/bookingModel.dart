class BookingModel {
  final int bookId;
  final String instructor;
  final String classname;
  final String place;
  final String from;
  final String to;
  final String placeType;
  final String day;
  final String insName;

  BookingModel({
    required this.bookId,
    required this.instructor,
    required this.classname,
    required this.place,
    required this.from,
    required this.to,
    required this.placeType,
    required this.day,
    required this.insName,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookId: map['book_id'] ?? 0,
      instructor: map['ins_id'] ?? "",
      classname: map['class_id'] ?? "",
      place: map['place_id'] ?? "",
      from: map['_from'] ?? "",
      to: map['_to'] ?? "",
      placeType: map['Places']?['place_type'] ?? "",
      day: map['day'] ?? "",
      insName: map['Instructors']?['ins_name'] ?? "",
    );
  }
}
