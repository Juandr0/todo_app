import 'package:flutter/material.dart';
import 'package:todo_app/shared-preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!!!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Welcome to the Todo-App!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FutureBuilder<bool>(
                  future: SharedPrefHelper.isFirstTime(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      bool isFirstTime = snapshot.data ?? true;
                      return Text(
                        //For testing- shows the shared pref seen value
                        'Seen Value: $isFirstTime',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await SharedPrefHelper.setFirstTime();
              // Navigate to the Todo screen
            },
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
