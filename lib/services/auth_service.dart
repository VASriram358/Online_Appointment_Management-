import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  final SharedPreferences prefs;
  static const String usersKey = 'users';
  static const String currentUserKey = 'currentUser';

  AuthService(this.prefs);

  // Register a new user
  Future<bool> register(
    String username,
    String password,
    bool isBusiness, {
    String? businessName,
    String? businessAddress,
  }) async {
    final Map<String, User> users = await _getUsers();

    if (users.containsKey(username)) {
      return false;
    }

    final user = User(
      username: username,
      password: password,
      isBusiness: isBusiness,
      businessName: isBusiness ? businessName : null,
      businessAddress: isBusiness ? businessAddress : null,
    );

    users[username] = user;

    try {
      await _saveUsers(users);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login a user
  Future<User?> login(String username, String password) async {
    final Map<String, User> users = await _getUsers();

    if (users.containsKey(username)) {
      if (users[username]!.password == password) {
        final user = users[username]!;
        await prefs.setString(currentUserKey, jsonEncode(user.toMap()));
        return user;
      }
    }

    return null;
  }

  // Logout current user
  Future<void> logout() async {
    await prefs.remove(currentUserKey);
  }

  // Get current logged in user
  Future<User?> getCurrentUser() async {
    final userJson = prefs.getString(currentUserKey);

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromMap(userMap);
    }

    return null;
  }

  // Get all business users
  Future<List<User>> getBusinessUsers() async {
    final users = await _getUsers();
    return users.values.where((user) => user.isBusiness).toList();
  }

  // Helper method to get all users
  Future<Map<String, User>> _getUsers() async {
    final usersJson = prefs.getString(usersKey);

    if (usersJson != null) {
      try {
        final Map<String, dynamic> usersMap = jsonDecode(usersJson);
        return usersMap.map((key, value) =>
            MapEntry(key, User.fromMap(value as Map<String, dynamic>)));
      } catch (e) {
        return {};
      }
    }

    return {};
  }

  // Helper method to save all users
  Future<void> _saveUsers(Map<String, User> users) async {
    final usersMap = users.map((key, value) => MapEntry(key, value.toMap()));
    final String usersJson = jsonEncode(usersMap);
    await prefs.setString(usersKey, usersJson);
  }
}
