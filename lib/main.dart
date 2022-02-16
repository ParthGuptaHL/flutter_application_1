import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration.dart';
import 'package:flutter_application_1/page/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(RegistrationAdapter());
  await Hive.openBox<Registration>('registrations');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hive Registration Page';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
      );
}
