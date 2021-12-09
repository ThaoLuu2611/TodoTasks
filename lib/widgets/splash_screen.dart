import 'package:flutter/material.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/database/database_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _bloc = TodoBloc();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 50), () {
      _bloc
          .initDatabase(null)
          .then((value) => Navigator.pushReplacementNamed(context, '/home'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Todo list',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 40.0),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.task_outlined,
              color: Colors.orange,
              size: 70.0,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Manabie',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
