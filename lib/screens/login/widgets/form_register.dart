import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Key keyForm;
  final InputDecoration Function(String value) decoration;
  final TextEditingController email;
  final TextEditingController name;
  final TextEditingController lastName;
  final TextEditingController password;
  const RegisterForm(
      {required this.keyForm,
      required this.decoration,
      required this.email,
      required this.name,
      required this.lastName,
      required this.password,
      super.key});
  @override
  State<RegisterForm> createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
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
                if (value!.isEmpty)
                  return 'Por favor, ingrese el correo electrónico';
                final RegExp emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                );
                if (!emailRegex.hasMatch(value))
                  return 'Por favor, ingrese un correo electrónico válido';
                return null;
              }),
          const SizedBox(height: 10),
          TextFormField(
            decoration: widget.decoration('Nombre'),
            controller: widget.name,
            validator: (value) =>
                value!.isEmpty ? 'Por favor ingrese un nombre' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: widget.decoration('Apellido'),
            controller: widget.lastName,
            validator: (value) =>
                value!.isEmpty ? 'Por favor ingrese su apellido' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: widget.decoration('Contraseña'),
            controller: widget.password,
            obscureText: true,
            validator: (value) =>
                value!.isEmpty ? 'Por favor ingrese una contraseña' : null,
          ),
        ],
      ),
    );
  }
}
