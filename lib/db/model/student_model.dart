import 'package:hive_flutter/adapters.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String age;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String phone;
  @HiveField(4)
  String? imagepath;
  StudentModel({
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.imagepath,
  });
}
