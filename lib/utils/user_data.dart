import 'package:myapp/services/storage_service.dart';

// Global user data storage
Map<String, dynamic>? currentUser;
List<Map<String, dynamic>> users = [];

// Initialize from storage
Future<void> initUserData() async {
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
}

// Save users to storage
Future<void> saveUsersToStorage() async {
  await StorageService.saveUsers(users);
}

// Save current user to storage
Future<void> saveCurrentUserToStorage() async {
  await StorageService.saveCurrentUser(currentUser);
}

// Add a new user
Future<void> addUser(Map<String, dynamic> newUser) async {
  users.add(newUser);
  await saveUsersToStorage();
}

// Update existing user
Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
  final index = users.indexWhere((user) => user['id'] == userId);
  if (index != -1) {
    users[index] = updatedData;
    await saveUsersToStorage();

    // Update current user if it's the same user
    if (currentUser != null && currentUser!['id'] == userId) {
      currentUser = updatedData;
      await saveCurrentUserToStorage();
    }
  }
}

// Delete user
Future<void> deleteUser(String userId) async {
  users.removeWhere((user) => user['id'] == userId);
  await saveUsersToStorage();

  // Log out if current user is deleted
  if (currentUser != null && currentUser!['id'] == userId) {
    currentUser = null;
    await StorageService.saveCurrentUser(null);
    await StorageService.setLoggedIn(false);
  }
}

// Login user
Future<void> loginUser(Map<String, dynamic> user) async {
  currentUser = user;
  await saveCurrentUserToStorage();
  await StorageService.setLoggedIn(true);
}

// Logout user
Future<void> logoutUser() async {
  currentUser = null;
  await StorageService.clearAll();
}

// Check if email exists
bool emailExists(String email) {
  return users.any(
      (user) => user['email'].toString().toLowerCase() == email.toLowerCase());
}

// Find user by email and password
Map<String, dynamic>? findUser(String email, String password) {
  return users.firstWhere(
      (user) =>
          user['email'].toString().toLowerCase() == email.toLowerCase() &&
          user['password'] == password,
      orElse: () => {});
}
