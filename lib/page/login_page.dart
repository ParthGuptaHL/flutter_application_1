import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/boxes.dart';
import 'package:flutter_application_1/model/registration.dart';
import 'package:flutter_application_1/page/registration_page.dart';
import 'package:flutter_application_1/widgets/registration_dialog.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "To App",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email ID",
                      labelStyle: TextStyle(
                          fontSize: 14, color: Colors.redAccent.shade100),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password ?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        List<Registration> ls =
                            Boxes.getRegistrations().values.toList();
                        bool isUserExist = ls.any((element) =>
                            element.email == emailController.text &&
                            element.password == passController.text);
                        print(isUserExist);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 50),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => RegistrationDialog(
                    onClickedDone: addRegistration,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addRegistration(String name, String email, String password) {
    final registration = Registration()
      ..name = name
      ..createdDate = DateTime.now()
      ..email = email
      ..password = password;

    final box = Boxes.getRegistrations();
    box.add(registration);
  }
}
