class UserModel {
  final String id;
  String username;
  String email;
  String password;
  int age;
  double weight;
  double height;
  String gender;
  bool isBodybuilder;
  final DateTime createdAt;
  bool darkMode;
  Map<String, dynamic> goals;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.gender = 'Male',
    this.isBodybuilder = false,
    DateTime? createdAt,
    this.darkMode = false,
    Map<String, dynamic>? goals,
  })  : createdAt = createdAt ?? DateTime.now(),
        goals = goals ?? {};

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      age: map['age'] ?? 0,
      weight: (map['weight'] ?? 0).toDouble(),
      height: (map['height'] ?? 0).toDouble(),
      gender: map['gender'] ?? 'Male',
      isBodybuilder: map['isBodybuilder'] ?? false,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      darkMode: map['darkMode'] ?? false,
      goals: map['goals'] is Map
          ? Map<String, dynamic>.from(map['goals'])
          : {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender,
      'isBodybuilder': isBodybuilder,
      'createdAt': createdAt.toIso8601String(),
      'darkMode': darkMode,
      'goals': goals,
    };
  }

  UserModel copyWith({
    String? username,
    String? email,
    String? password,
    int? age,
    double? weight,
    double? height,
    String? gender,
    bool? isBodybuilder,
    bool? darkMode,
    Map<String, dynamic>? goals,
  }) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      isBodybuilder: isBodybuilder ?? this.isBodybuilder,
      createdAt: createdAt,
      darkMode: darkMode ?? this.darkMode,
      goals: goals ?? Map.from(this.goals),
    );
  }
}
