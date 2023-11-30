import 'package:natural_languaje_processing_mobile/Firebase/firebase_client.dart';
import 'package:natural_languaje_processing_mobile/models/user.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_event.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_languaje_processing_mobile/screens/login/helpers/type_form.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserNLP user = new UserNLP();
  LoginBloc() : super(InitState()) {
    on<LogInEvent>(onLogInEvent);
    on<CreateAccountEvent>(onCreateAccountEvent);
    on<LoadFormEvent>(onLoadFormEvent);
    on<CurrentLoginEvent>(onCurrentLoginEvent);
    on<ResetEvent>(onResetEvent);
  }

  void onLogInEvent(LogInEvent event, Emitter<LoginState> emit) async {
    try {
      final firebase = FirebaseClient("users");
      final Login = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      String id = Login.user!.uid;
      final data = await firebase.getDocById(id: id);
      UserNLP userLogin = UserNLP.fromMap(data as Map<String, dynamic>);
      emit(LoginSuccessState(user: userLogin));
    } on FirebaseAuthException {
      emit(LoginErrorState('Las crendenciales de acceso no son válidas.'));
    }
  }

  void onCreateAccountEvent(
      CreateAccountEvent event, Emitter<LoginState> emit) async {
    try {
      final firebase = FirebaseClient("users");
      final userLogin = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      String id = userLogin.user!.uid;
      firebase.create(id: id, user: this.user);
      emit(LoginSuccessState(user: user));
    } on FirebaseAuthException catch (e) {
      // Manejo de excepciones específicas de FirebaseAuth
      switch (e.code) {
        case 'email-already-in-use':
          emit(LoginErrorState('El correo electrónico ya está en uso.'));
          break;
        case 'weak-password':
          emit(
              LoginErrorState('La contraseña debe tener minimo 6 caracteres.'));
          break;
        default:
          emit(LoginErrorState('Problemas internos. Intentelo mas tarde.'));
      }
    }
  }

  void onLoadFormEvent(LoadFormEvent event, Emitter<LoginState> emit) {
    FormType type = event.type;
    emit(HandleFormState(type: type));
  }

  void onResetEvent(ResetEvent event, Emitter<LoginState> emit) {
    emit(ResetState());
  }

  void onCurrentLoginEvent(
      CurrentLoginEvent event, Emitter<LoginState> emit) async {
    String currentId = event.id;
    try {
      final firebase = FirebaseClient("users");
      final data = await firebase.getDocById(id: currentId);
      UserNLP currentUser = UserNLP.fromMap(data as Map<String, dynamic>);
      emit(LoginSuccessState(user: currentUser));
    } catch (e) {
      emit(LoginErrorState((e).toString()));
    }
  }
}
