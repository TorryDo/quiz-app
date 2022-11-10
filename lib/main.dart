import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/src/features/auth/domain/models/account.dart';
import 'package:quiz_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:quiz_app/src/features/auth/presentation/auth_screen.dart';
import 'package:quiz_app/src/features/auth/presentation/auth_viewmodel.dart';
import 'package:quiz_app/src/features/topics/presentation/topic_screen.dart';
import 'package:quiz_app/utils/models/resource/resource_x.dart';

import 'di/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final AuthRepository _authRepository = locator<AuthRepository>();

  // Account? account;

  // _MyHomePageState() {
  //   _authRepository.getCurrentAccount().onSuccess((value) {
  //     account = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey, body: _providers());
  }

  Widget _providers() {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
    ], child: const MainNav());
  }

  // Widget _navigator() {
  //
  // }

}

class MainNav extends StatefulWidget {
  const MainNav({Key? key}) : super(key: key);

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {

  Account? account;

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context);

    account = authViewModel.account;

    if (account == null) {
      return const AuthScreen();
    } else {
      return const TopicScreen();
    }
  }
}

