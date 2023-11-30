import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Key keyForm;
  final InputDecoration Function(String value) decoration;
  final TextEditingController email;
  final TextEditingController password;

  const LoginForm(
      {required this.keyForm,
      required this.decoration,
      required this.email,
      required this.password,
      super.key});
  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.keyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          TextFormField(
              decoration: widget.decoration('Correo Electronico'),
              controller: widget.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) return 'Por favor, ingrese el correo electrónico';
                final RegExp emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                );
                if (!emailRegex.hasMatch(value)) return 'Por favor, ingrese un correo electrónico válido';
                return null;
              }),
          const SizedBox(height: 10),
          TextFormField(
            decoration: widget.decoration('Contraseña'),
            controller: widget.password,
            validator: (value) => value!.isEmpty ? 'Por favor ingrese una contraseña' : null,
          )
        ],
      ),
    );
  }
}
