import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/auth/presentation/auth_viewmodel.dart';
import 'package:quiz_app/src/features/topics/presentation/topic_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthViewModel _authViewModel;


  void _navigateToTopicScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const TopicScreen()));
  }

  @override
  Widget build(BuildContext context) {

    _authViewModel = Provider.of<AuthViewModel>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.redAccent,
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: _authViewModel.signInWithGoogle,
            child: const Text("signIn With Google")),
        ElevatedButton(
            onPressed: _authViewModel.signInAsGuest,
            child: const Text("signIn as Guest"))
      ],
    );
  }
}
