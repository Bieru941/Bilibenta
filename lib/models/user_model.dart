class UserModel {
  final String id;
  final String? studentId;
  final String name;
  final String email;
  final String? role;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    this.studentId,
    required this.name,
    required this.email,
    this.role,
    this.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '').toString(),
      studentId: map['student_id']?.toString(),
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      role: map['role']?.toString(),
      avatarUrl: map['avatar_url']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'student_id': studentId,
    'name': name,
    'email': email,
    'role': role,
    'avatar_url': avatarUrl,
  };
}
