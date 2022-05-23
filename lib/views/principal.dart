import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
      ]),
      body: SizedBox(
        child: Center(
          child: Column(
            children: [
              const Text('Programador de reuniones'),
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed('login');
                  },
                  child: const Text("login pro max 21")),
              const Text('profile view'),
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed('profileView');
                  },
                  child: const Text("profile view")),
            ],
          ),
        ),
      ),
    );
  }
}
