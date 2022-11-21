import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/quiz/quiz_screen.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume/volume_provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume/volume_screen.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_provider.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_result_screen.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import 'di/locator.dart';
import 'firebase_options.dart';
import 'src/features/auth/domain/models/account.dart';
import 'src/features/auth/presentation/auth_provider.dart';
import 'src/features/auth/presentation/auth_screen.dart';
import 'src/features/quiz/presentation/screen/quiz/quiz_provider.dart';
import 'src/features/quiz/presentation/screen/topic/topic_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TopicProvider(locator())),
        ChangeNotifierProvider(
            create: (context) => VolumeProvider(locator(), locator())),
        ChangeNotifierProvider(create: (context) => QuizProvider(locator())),
        ChangeNotifierProvider(create: (context) => SummaryProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: Routes.INITIAL,
        routes: {
          Routes.INITIAL: (context) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
          Routes.AUTH_SCREEN: (context) => const AuthScreen(),
          Routes.TOPIC_SCREEN: (context) => const TopicScreen(),
          Routes.VOLUME_SCREEN: (context) => const VolumeScreen(),
          Routes.QUIZ_SCREEN: (context) => const QuizScreen(),
          Routes.SUMMARY_SCREEN: (context) => const SummaryResultScreen()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
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
  Account? account;

  @override
  Widget build(BuildContext context) {
    var authViewModel = context.provider<AuthProvider>();

    account = authViewModel.account;

    return Material(
      child: () {
        if (account == null) {
          return const AuthScreen();
        } else {
          return const TopicScreen();
        }
      }(),
    );
  }
}
