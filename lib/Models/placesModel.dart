class PlacesModel {
  String place_type;
  String place_name;

  PlacesModel({required this.place_type, required this.place_name});

  // factory PlacesModel.fromMap(Map<String, dynamic> map) {
  //   return PlacesModel(
  //     place_type: map['place_type'],
  //     place_name: map['place_name'],
  //   );
  // }
}
