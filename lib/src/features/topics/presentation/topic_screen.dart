import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/auth/presentation/auth_viewmodel.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {


  @override
  Widget build(BuildContext context) {

    var vm = Provider.of<AuthViewModel>(context);

    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: vm.signOut,
          child: const Text("sign out"),
        ),
      ),
    );
  }
}
