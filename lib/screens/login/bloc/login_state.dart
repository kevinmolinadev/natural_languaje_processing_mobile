import 'package:natural_languaje_processing_mobile/models/user.dart';
import 'package:natural_languaje_processing_mobile/screens/login/helpers/type_form.dart';

class LoginState {}

class InitState extends LoginState {}

class LoginSuccessState extends LoginState {
  UserNLP user;
  LoginSuccessState({required this.user});
}

class LoginErrorState extends LoginState {
  String message;
  LoginErrorState(this.message);
}

class HandleFormState extends LoginState {
  FormType type;
  HandleFormState({this.type = FormType.Login});
}

class CurrentLoginState extends LoginState {
  UserNLP user;
  CurrentLoginState({required this.user});
}

class ResetState extends LoginState {}
