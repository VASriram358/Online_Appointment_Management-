// lib/services/appointment_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/appointment.dart';

class AppointmentService {
  final SharedPreferences prefs;
  static const String appointmentsKey = 'appointments';

  AppointmentService(this.prefs);

  // Create a new appointment
  Future<bool> createAppointment(String customerId, String businessId, DateTime dateTime) async {
    // Get existing appointments
    final List<Appointment> appointments = await getAppointments();

    // Create new appointment
    final appointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerId: customerId,
      businessId: businessId,
      dateTime: dateTime,
      isApproved: false,
    );

    // Add appointment to the list
    appointments.add(appointment);

    // Save updated appointments list
    await _saveAppointments(appointments);

    return true;
  }

  // Approve an appointment
  Future<bool> approveAppointment(String appointmentId) async {
    // Get existing appointments
    final List<Appointment> appointments = await getAppointments();

    // Find appointment index
    final index = appointments.indexWhere((appt) => appt.id == appointmentId);

    if (index == -1) {
      return false;
    }

    // Create approved appointment
    final appointment = appointments[index];
    final approvedAppointment = Appointment(
      id: appointment.id,
      customerId: appointment.customerId,
      businessId: appointment.businessId,
      dateTime: appointment.dateTime,
      isApproved: true,
    );

    // Update appointment in the list
    appointments[index] = approvedAppointment;

    // Save updated appointments list
    await _saveAppointments(appointments);

    return true;
  }

  // Get all appointments
  Future<List<Appointment>> getAppointments() async {
    final appointmentsJson = prefs.getString(appointmentsKey);

    if (appointmentsJson != null) {
      final List<dynamic> appointmentsList = jsonDecode(appointmentsJson);

      return appointmentsList
          .map((item) => Appointment.fromMap(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  // Get appointments for a customer
  Future<List<Appointment>> getCustomerAppointments(String customerId) async {
    final appointments = await getAppointments();

    return appointments
        .where((appt) => appt.customerId == customerId)
        .toList();
  }

  // Get appointments for a business
  Future<List<Appointment>> getBusinessAppointments(String businessId) async {
    final appointments = await getAppointments();

    return appointments
        .where((appt) => appt.businessId == businessId)
        .toList();
  }

  // Helper method to save all appointments
  Future<void> _saveAppointments(List<Appointment> appointments) async {
    final appointmentsList = appointments.map((appt) => appt.toMap()).toList();

    await prefs.setString(appointmentsKey, jsonEncode(appointmentsList));
  }
}