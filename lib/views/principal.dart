import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            children: [
              const Text('Programador de reuniones'),
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed('login');
                  },
                  child: const Text("login pro max 21"))
            ],
          ),
        ),
      ),
    );
  }
}
