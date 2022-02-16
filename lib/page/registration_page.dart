import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/model/registration.dart';
import 'package:flutter_application_1/widgets/registration_dialog.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Registered Users'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Registration>>(
          valueListenable: Boxes.getRegistrations().listenable(),
          builder: (context, box, _) {
            List<Registration> registrations =
                box.values.toList().cast<Registration>();

            return buildContent(registrations);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => RegistrationDialog(
              onClickedDone: addRegistration,
            ),
          ),
        ),
      );

  Widget buildContent(List<Registration> registrations) {
    if (registrations.isEmpty) {
      return Center(
        child: Text(
          'No users yet!',
          style: TextStyle(fontSize: 22),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: registrations.length,
                itemBuilder: (BuildContext context, int index) {
                  final registration = registrations[index];

                  return buildRegistration(context, registration);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildRegistration(
    BuildContext context,
    Registration registration,
  ) {
    final date = DateFormat.yMMMd().format(registration.createdDate);

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          registration.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date),
        children: [
          buildButtons(context, registration),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Registration registration) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegistrationDialog(
                    registration: registration,
                    onClickedDone: (name, email, password) =>
                        editRegistration(registration, name, email, password),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteRegistration(registration),
            ),
          )
        ],
      );

  Future addRegistration(String name, String email, String password) async {
    final registration = Registration()
      ..name = name
      ..createdDate = DateTime.now()
      ..email = email
      ..password = password;

    final box = Boxes.getRegistrations();
    box.add(registration);
  }

  void editRegistration(
    Registration registration,
    String name,
    String email,
    String password,
  ) {
    registration.name = name;
    registration.email = email;
    registration.password = password;

    registration.save();
  }

  void deleteRegistration(Registration registration) {
    registration.delete();
  }
}
