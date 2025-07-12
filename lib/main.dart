
// Fix for main.dart - Update the routes section

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/customer_dashboard.dart';
import 'screens/business_dashboard.dart';
import 'models/user.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences instance
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Initialize Auth Service
  AuthService authService = AuthService(prefs);

  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<User?>(
        future: authService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // If user is logged in, direct to appropriate dashboard
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            if (user.isBusiness) {
              return BusinessDashboard(user: user, authService: authService);
            } else {
              return CustomerDashboard(user: user, authService: authService);
            }
          }

          // Otherwise, show login screen
          return LoginScreen(authService: authService);
        },
      ),
      // UPDATED ROUTES - this is the key change
      routes: {
        '/login': (context) => LoginScreen(authService: authService),
        '/register': (context) => RegisterScreen(authService: authService),
        '/customer_dashboard': (context) {
          // Get the arguments or provide a default
          final args = ModalRoute.of(context)?.settings.arguments;
          final user = args is User ? args : User(username: "default", password: "", isBusiness: false);
          return CustomerDashboard(user: user, authService: authService);
        },
        '/business_dashboard': (context) {
          // Get the arguments or provide a default
          final args = ModalRoute.of(context)?.settings.arguments;
          final user = args is User ? args : User(username: "default", password: "", isBusiness: true);
          return BusinessDashboard(user: user, authService: authService);
        },
      },
      // Add this onGenerateRoute handler to catch routing errors
      onGenerateRoute: (settings) {
        print("Generating route for: ${settings.name}");

        // Default handling for unknown routes
        if (settings.name == '/business_dashboard') {
          final args = settings.arguments;
          final user = args is User ? args : User(username: "default", password: "", isBusiness: true);
          return MaterialPageRoute(
            builder: (context) => BusinessDashboard(user: user, authService: authService),
          );
        } else if (settings.name == '/customer_dashboard') {
          final args = settings.arguments;
          final user = args is User ? args : User(username: "default", password: "", isBusiness: false);
          return MaterialPageRoute(
            builder: (context) => CustomerDashboard(user: user, authService: authService),
          );
        }

        // Default fallback to login screen
        return MaterialPageRoute(
          builder: (context) => LoginScreen(authService: authService),
        );
      },
      // Add this to handle unknown routes
      onUnknownRoute: (settings) {
        print("Unknown route: ${settings.name}");
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Route Not Found")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Oops! Page not found."),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text("Return to Login"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}