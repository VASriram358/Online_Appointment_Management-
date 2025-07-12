// lib/screens/customer_dashboard.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/appointment.dart';
import '../services/auth_service.dart';
import '../services/appointment_service.dart';
import 'create_appointment_screen.dart';

class CustomerDashboard extends StatefulWidget {
  final User user;
  final AuthService authService;

  const CustomerDashboard({
    Key? key,
    required this.user,
    required this.authService,
  }) : super(key: key);

  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  late AppointmentService _appointmentService;
  List<Appointment> _appointments = [];
  List<User> _businessUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAppointmentService();
  }

  Future<void> _initAppointmentService() async {
    final prefs = await SharedPreferences.getInstance();
    _appointmentService = AppointmentService(prefs);
    final authService = AuthService(prefs);
    try {
      final businessUsers = await authService.getBusinessUsers();
      setState(() {
        _businessUsers = businessUsers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading business data: $e')),
      );
    }
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final appointments = await _appointmentService.getCustomerAppointments(widget.user.username);
      setState(() {
        _appointments = appointments;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading appointments: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await widget.authService.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome, ${widget.user.username}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Your Appointments',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: _appointments.isEmpty
                      ? const Center(
                          child: Text('No appointments found'),
                        )
                      : ListView.builder(
                          itemCount: _appointments.length,
                          itemBuilder: (context, index) {
                            final appointment = _appointments[index];
                            final businessUser = _businessUsers.firstWhere(
                              (user) => user.username == appointment.businessId,
                              orElse: () => User(
                                username: appointment.businessId,
                                password: '',
                                isBusiness: true,
                              ),
                            );

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: ListTile(
                                title: Text(
                                  businessUser.businessName ?? businessUser.username,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (businessUser.businessAddress != null)
                                      Text(
                                        businessUser.businessAddress!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Date: ${appointment.dateTime.toString().substring(0, 16)}',
                                    ),
                                  ],
                                ),
                                trailing: appointment.isApproved
                                    ? const Chip(
                                        label: Text('Approved'),
                                        backgroundColor: Colors.green,
                                        labelStyle: TextStyle(color: Colors.white),
                                      )
                                    : const Chip(
                                        label: Text('Pending'),
                                        backgroundColor: Colors.orange,
                                        labelStyle: TextStyle(color: Colors.white),
                                      ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAppointmentScreen(
                customerId: widget.user.username,
                appointmentService: _appointmentService,
              ),
            ),
          );

          if (result == true) {
            _loadAppointments();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}