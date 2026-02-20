class UserModel {
  final String email;
  final String? id;
  final String firstName;
  final String lastName;
  final String? englishLevel;
  final String ?age;
  final String ?englishStudy;
  List<String> ?hobbies;
  final String? image;
  final String? language;
  String? learningStyle;


  UserModel({
    required this.email,
    this.id,
    this.language,
    this.englishLevel,
    this.age,
    this.englishStudy,
    this.hobbies,

    required this.firstName,
    required this.lastName,
    this.image,
    this.learningStyle,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'language': language,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
       'englishLevel': englishLevel,
      'age': age,
      'englishStudy': englishStudy,
      'hobbies': hobbies,
      'learningStyle': learningStyle,

    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      language: json['language'],
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
      englishLevel: json['englishLevel'],
      age: json['age'],
      englishStudy: json['englishStudy'],
       hobbies: (json['hobbies'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }
}
