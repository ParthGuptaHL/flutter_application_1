import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration.dart';

class RegistrationDialog extends StatefulWidget {
  final Registration? registration;
  final Function(String name, String email, String password) onClickedDone;

  const RegistrationDialog({
    Key? key,
    this.registration,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _RegistrationDialogState createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.registration != null) {
      final registration = widget.registration!;

      nameController.text = registration.name;
      emailController.text = registration.email;
      passwordController.text = registration.password;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.registration != null;
    final title = isEditing ? 'Edit Registration' : 'Add Registration';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildEmail(),
              SizedBox(height: 8),
              buildPassword(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Email',
        ),
        validator: (email) =>
            email != null && email.isEmpty ? 'Enter an Email' : null,
      );

  Widget buildPassword() => TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Password',
        ),
        validator: (password) =>
            password != null && password.isEmpty ? 'Enter a Password' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final email = emailController.text;
          final password = passwordController.text;

          widget.onClickedDone(name, email, password);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
