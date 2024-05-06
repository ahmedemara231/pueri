class Hospital_Model {
  dynamic? rate;
  String? id; // You can use either int or String, depending on your use case
  int? avilable;
  bool? supported;
  String? location;
  String? price;
  String? location_place;
  String? hospital_name;
  bool? topRated;

  // Constructor
  Hospital_Model({
    required this.hospital_name,
    required this.location,
    required this.id,
    required this.supported,
    required this.price,
    required this.location_place,
    required this.topRated,
    required this.avilable,
    required this.rate,
  });

  // Factory method to create a User object from a JSON map
  factory Hospital_Model.fromJson(Map<String, dynamic> json,String id) {
    return Hospital_Model(
      avilable: json['avilable'],
      hospital_name: json['hospital_name'],
      id: id,
      location: json['location'] + ', ' + json['subLocation'],
      price: json['price'],
      rate: json['rate'],
      topRated: json['topRated'],
      supported: json['supported'],
      location_place: json['location_place'],
    );
  }

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'supported': supported,
      'rate': rate,
      'location': location,
      'price': price,
      'location_place': location_place,
      'hospital_name': hospital_name,
      'id': id,
      'topRated': topRated,
      'avilable': avilable,
    };
  }
}
