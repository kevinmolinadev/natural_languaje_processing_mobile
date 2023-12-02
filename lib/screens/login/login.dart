import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:natural_languaje_processing_mobile/helpers/navigate.dart';

import 'package:natural_languaje_processing_mobile/models/user.dart';
import 'package:natural_languaje_processing_mobile/screens/home/home.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_bloc.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_event.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_state.dart';
import 'package:natural_languaje_processing_mobile/screens/login/helpers/type_form.dart';
import 'package:natural_languaje_processing_mobile/screens/login/widgets/form_login.dart';
import 'package:natural_languaje_processing_mobile/screens/login/widgets/form_register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FormType currentFormType = FormType.Login;

  InputDecoration _decor(String label) {
    return InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF9e0044), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            switch (state.runtimeType) {
              case InitState:
                if (FirebaseAuth.instance.currentUser != null) {
                  String id = FirebaseAuth.instance.currentUser!.uid;
                  BlocProvider.of<LoginBloc>(context)
                      .add(CurrentLoginEvent(id: id));
                } else {
                  return _form(type: currentFormType);
                }
                return const CircularProgressIndicator(color: Color(0xFF9e0044),);
              case LoginSuccessState:
                UserNLP user = (state as LoginSuccessState).user;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  navigate(
                      context: context,
                      screen: Home(user: user),
                      method: MethodNavigate.replace);
                });
                BlocProvider.of<LoginBloc>(context).add(ResetEvent());
                return const CircularProgressIndicator(color: Color(0xFF9e0044),);
              case CurrentLoginState:
                UserNLP user = (state as CurrentLoginState).user;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  navigate(
                      context: context,
                      screen: Home(user: user),
                      method: MethodNavigate.replace);
                });
                return const CircularProgressIndicator(color: Color(0xFF9e0044),);
              case HandleFormState:
                FormType type = (state as HandleFormState).type;
                return _form(type: type);
              case ResetState:
                return _form(type: FormType.Login);
              case LoginErrorState:
                String messageError = (state as LoginErrorState).message;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(messageError),
                    ),
                  );
                });
                return _form(type: currentFormType);
              default:
                return const CircularProgressIndicator(color: Color(0xFF9e0044),);
            }
          })),
    );
  }

  Widget _form({required FormType type}) {
    currentFormType = type;
    bool isLogin = type == FormType.Login;
    String message = isLogin
        ? "¿No tienes una cuenta? | Registrate"
        : "¿Ya tienes una cuenta? | Iniciar Sesion";
    String textButton = isLogin ? "Iniciar Sesion" : "Crear Cuenta";
    FormType handleFormType = isLogin ? FormType.Register : FormType.Login;

    final form = Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Encabezado con las palabras "UNIVALLE" y "SANTA CRUZ"
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Column(
              children: [
                Text(
                  "UNIVALLE",
                  style: TextStyle(
                    fontSize: 48.0, // Aumentado el tamaño
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9e0044), // Color principal
                  ),
                ),
                Text(
                  "SANTA CRUZ",
                  style: TextStyle(
                    fontSize: 18.0, // Aumentado el tamaño
                    color: Color(0xFF483c46), // Color secundario
                  ),
                ),
              ],
            ),
          ),
          (type == FormType.Login)
              ? LoginForm(
                  keyForm: _formKey,
                  decoration: _decor,
                  email: _emailController,
                  password: _passwordController)
              : RegisterForm(
                  keyForm: _formKey,
                  decoration: _decor,
                  email: _emailController,
                  name: _nameController,
                  lastName: _lastNameController,
                  password: _passwordController),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text((message.split("|")[0]).trim()),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoadFormEvent(handleFormType));
                  },
                  child: Text((message.split("|")[1]).trim(),
                      style: const TextStyle(color: Color(0xFF9e0044))),
                )
              ],
            ),
          ),
          // Cambiado el color del botón
          MaterialButton(
            color: const Color(0xFF9e0044), // Cambiado el color
            textColor: Colors.white,
            onPressed: () => _submitForm(currentFormType),
            child: Text(textButton),
          )
        ],
      ),
    );
    Widget scroll = SingleChildScrollView(child: form);
    return scroll;
  }

  void _submitForm(FormType type) async {
    if (_formKey.currentState!.validate()) {
      (type == FormType.Login) ? _submitLogin() : _submitRegister();
    }
  }

  void _submitLogin() {
    final user = BlocProvider.of<LoginBloc>(context).user;
    user.email = _emailController.text;
    user.password = _passwordController.text;
    BlocProvider.of<LoginBloc>(context).add(LogInEvent());
  }

  void _submitRegister() {
    final user = BlocProvider.of<LoginBloc>(context).user;
    user.email = _emailController.text;
    user.name = _nameController.text;
    user.lastName = _lastNameController.text;
    user.password = _passwordController.text;
    BlocProvider.of<LoginBloc>(context).add(CreateAccountEvent());
  }
}
