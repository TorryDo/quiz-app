import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/quiz_provider.dart';

import 'di/locator.dart';
import 'firebase_options.dart';
import 'src/features/auth/domain/models/account.dart';
import 'src/features/auth/presentation/auth_provider.dart';
import 'src/features/auth/presentation/auth_screen.dart';
import 'src/features/quiz/presentation/topic_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => initAuthProvider()),
        ChangeNotifierProvider(create: (context) => initQuizProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey, body: _providers());
  }

  Widget _providers() {
    // return MultiProvider(providers: [
    //   ChangeNotifierProvider(create: (context) => initAuthProvider()),
    //   ChangeNotifierProvider(create: (context) => initTopicProvider())
    // ], child: const MainNav());
    return const MainNav();
  }
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
    var authViewModel = Provider.of<AuthProvider>(context);

    account = authViewModel.account;

    if (account == null) {
      return const AuthScreen();
    } else {
      return const TopicScreen();
    }
  }
}
