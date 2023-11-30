import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:natural_languaje_processing_mobile/screens/login/bloc/login_bloc.dart';
import 'package:natural_languaje_processing_mobile/screens/login/login.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NLP',
          home: Login(),
        ));
  }
}
