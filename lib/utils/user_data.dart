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
    "waist": 80.0,
    "isBodybuilder": false,
    "caloriesGoal": 2500,
    "createdAt": "2026-01-23",
    "goals": {
      // Add goals field
      'weight': {'target': 75.0, 'current': 71.3, 'unit': 'kg', 'active': true},
      'protein': {
        'target': 120,
        'current': 100,
        'unit': 'protein',
        'active': true
      },
      'calories': {
        'target': 2500,
        'current': 1800,
        'unit': 'cal',
        'active': true
      },
    },
  },
];
