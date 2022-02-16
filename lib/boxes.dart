import 'package:flutter_application_1/model/registration.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Registration> getRegistrations() =>
      Hive.box<Registration>('registrations');
}
