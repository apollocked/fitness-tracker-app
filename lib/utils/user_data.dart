// Global user data storage
Map<String, dynamic>? currentUser;

List<Map<String, dynamic>> users = [
  {
    "id": "72",
    "username": "apollo",
    "email": "hama@",
    "password": "aaaaaaaa",
    "age": 24,
    "weight": 72.0,
    "height": 170.0,
    "gender": "Male",
    "isBodybuilder": false,
    "caloriesGoal": 2500,
    "createdAt": "2026-01-23",
  },
  {
    "id": "1",
    "username": "john_doe",
    "email": "john@fitness.com",
    "password": "password123",
    "age": 25,
    "weight": 75.0,
    "height": 175.0,
    "gender": "Male",
    "isBodybuilder": false,
    "caloriesGoal": 2500,
    "createdAt": "2025-01-20",
  },
  {
    "id": "2",
    "username": "jane_smith",
    "email": "jane@fitness.com",
    "password": "password123",
    "age": 28,
    "weight": 65.0,
    "height": 165.0,
    "gender": "Female",
    "isBodybuilder": false,
    "caloriesGoal": 2500,
    "createdAt": "2025-01-21",
  },
];

// Store measurements per user
Map<String, List<Map<String, dynamic>>> userMeasurements = {
  "1": [
    {
      "date": "2025-01-20T10:00:00.000",
      "weight": 75.0,
      "waist": 80.0,
    },
  ],
  "2": [
    {
      "date": "2025-01-21T10:00:00.000",
      "weight": 65.0,
      "waist": 70.0,
    },
  ],
};

// Get current user's measurements
List<Map<String, dynamic>> getCurrentUserMeasurements() {
  if (currentUser == null) return [];
  String userId = currentUser!['id'];
  return userMeasurements[userId] ?? [];
}

// Add measurement for current user
void addMeasurementForCurrentUser(Map<String, dynamic> measurement) {
  if (currentUser == null) return;
  String userId = currentUser!['id'];

  if (userMeasurements[userId] == null) {
    userMeasurements[userId] = [];
  }

  userMeasurements[userId]!.add(measurement);
}
