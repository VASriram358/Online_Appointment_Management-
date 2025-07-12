// lib/models/appointment.dart
class Appointment {
  final String id;
  final String customerId;
  final String businessId;
  final DateTime dateTime;
  final bool isApproved;

  Appointment({
    required this.id,
    required this.customerId,
    required this.businessId,
    required this.dateTime,
    this.isApproved = false,
  });

  // Convert Appointment object to a map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'businessId': businessId,
      'dateTime': dateTime.toIso8601String(),
      'isApproved': isApproved,
    };
  }

  // Create Appointment object from a map from SharedPreferences
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      customerId: map['customerId'],
      businessId: map['businessId'],
      dateTime: DateTime.parse(map['dateTime']),
      isApproved: map['isApproved'],
    );
  }
}