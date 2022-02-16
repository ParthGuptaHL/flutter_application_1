import 'package:hive/hive.dart';

part 'registration.g.dart';

@HiveType(typeId: 0)
class Registration extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime createdDate;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String password;
}
