import 'package:natural_languaje_processing_mobile/screens/login/helpers/type_form.dart';

abstract class LoginEvent {}

class LogInEvent extends LoginEvent {}

class CreateAccountEvent extends LoginEvent {}

class LoadFormEvent extends LoginEvent {
  FormType type;
  LoadFormEvent(this.type);
}

class CurrentLoginEvent extends LoginEvent {
  String id;
  CurrentLoginEvent({required this.id});
}

class ResetEvent extends LoginEvent {}
