import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;
  UserModel({
    required this.name,
    this.photoURL,
  });


  UserModel copyWith({
    String? name,
    String? photoURL,
  }) {
    return UserModel(
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    if(photoURL != null){
      result.addAll({'photoURL': photoURL});
    }
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, photoURL: $photoURL)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.photoURL == photoURL;
  }

  @override
  int get hashCode => name.hashCode ^ photoURL.hashCode;
}
