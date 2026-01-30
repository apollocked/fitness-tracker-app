// ignore_for_file: avoid_print

import 'package:myapp/services/storage_service.dart';

// Global user data storage
Map<String, dynamic>? currentUser;
List<Map<String, dynamic>> users = [];

// Initialize from storage
Future<void> initUserData() async {
  try {
    // Get users from storage
    users = StorageService.getUsers();

    // Get current user from storage
    currentUser = StorageService.getCurrentUser();

    // If no users in storage, add default demo user
    if (users.isEmpty) {
      final defaultUser = {
        "id": "demo_001",
        "username": "demo_user",
        "email": "demo@fitness.com",
        "password": "demo123",
        "age": 25,
        "weight": 70.0,
        "height": 175.0,
        "gender": "Male",
        "isBodybuilder": false,
        "createdAt": DateTime.now().toIso8601String(),
        "darkMode": false,
        "goals": {
          'weight': {
            'target': 75.0,
            'current': 70.0,
            'unit': 'kg',
            'active': true,
            'goalType': 'gain'
          },
          'protein': {'target': 120, 'unit': 'g', 'active': true},
          'calories': {'target': 2500, 'unit': 'cal', 'active': true},
        },
      };

      users.add(defaultUser);
      await StorageService.saveUsers(users);
    }
  } catch (e) {
    print('Error initializing user data: $e');
    // Initialize with empty data on error
    users = [];
    currentUser = null;
  }
}

// Save users to storage
Future<void> saveUsersToStorage() async {
  try {
    await StorageService.saveUsers(users);
  } catch (e) {
    print('Error saving users: $e');
    rethrow;
  }
}

// Save current user to storage
Future<void> saveCurrentUserToStorage() async {
  try {
    await StorageService.saveCurrentUser(currentUser);
  } catch (e) {
    print('Error saving current user: $e');
    rethrow;
  }
}

// Add a new user
Future<void> addUser(Map<String, dynamic> newUser) async {
  try {
    users.add(newUser);
    await saveUsersToStorage();
  } catch (e) {
    print('Error adding user: $e');
    rethrow;
  }
}

// Update existing user
Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
  try {
    final index = users.indexWhere((user) => user['id'] == userId);
    if (index != -1) {
      users[index] = {...users[index], ...updatedData};
      await saveUsersToStorage();

      // Update current user if it's the same user
      if (currentUser != null && currentUser!['id'] == userId) {
        currentUser = users[index];
        await saveCurrentUserToStorage();
      }
    }
  } catch (e) {
    print('Error updating user: $e');
    rethrow;
  }
}

// Delete user
Future<void> deleteUser(String userId) async {
  try {
    print('Deleting user with ID: $userId');

    // Store user data before deletion for potential recovery
    final userToDelete = users.firstWhere(
      (user) => user['id'] == userId,
      orElse: () => {},
    );

    if (userToDelete.isNotEmpty) {
      // Remove from users list
      users.removeWhere((user) => user['id'] == userId);

      // IMPORTANT: Save the updated users list to storage
      await saveUsersToStorage();

      print('User removed from users list. Total users now: ${users.length}');

      // Log out if current user is deleted
      if (currentUser != null && currentUser!['id'] == userId) {
        print('Clearing current user session');
        currentUser = null;
        await StorageService.saveCurrentUser(null);
        await StorageService.setLoggedIn(false);
      }
      print('User $userId deleted successfully');
    } else {
      print('User $userId not found for deletion');
    }
  } catch (e) {
    print('Error deleting user: $e');
    rethrow;
  }
}

// Login user
Future<void> loginUser(Map<String, dynamic> user) async {
  try {
    currentUser = user;
    await saveCurrentUserToStorage();
    await StorageService.setLoggedIn(true);
  } catch (e) {
    print('Error logging in user: $e');
    rethrow;
  }
}

// Logout user
Future<void> logoutUser() async {
  try {
    currentUser = null;
    await StorageService.clearAll();
  } catch (e) {
    print('Error logging out: $e');
    rethrow;
  }
}

// Check if email exists
bool emailExists(String email) {
  try {
    return users.any((user) =>
        user['email'].toString().toLowerCase() == email.toLowerCase());
  } catch (e) {
    print('Error checking email existence: $e');
    return false;
  }
}

// Check if user exists by ID
bool userExists(String userId) {
  try {
    return users.any((user) => user['id'] == userId);
  } catch (e) {
    print('Error checking user existence: $e');
    return false;
  }
}

// Find user by email and password
Map<String, dynamic>? findUser(String email, String password) {
  try {
    print('Finding user with email: $email');
    print('Total users in list: ${users.length}');

    // Filter users by email first (case-insensitive)
    final matchingUsers = users.where((user) =>
        user['email'].toString().toLowerCase() == email.toLowerCase());

    print('Users with matching email: ${matchingUsers.length}');

    // Then check password
    for (final user in matchingUsers) {
      if (user['password'] == password) {
        print('User found: ${user['username']}');
        return user;
      }
    }

    print('No user found with matching credentials');
    return null;
  } catch (e) {
    print('Error finding user: $e');
    return null;
  }
}
