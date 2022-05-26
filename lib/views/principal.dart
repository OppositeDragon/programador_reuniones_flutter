import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';

class Principal extends ConsumerStatefulWidget {
  const Principal({super.key});

  @override
  ConsumerState<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends ConsumerState<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => ref.read(themeProvider).setTheme(),
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () => ref.read(loginProvider).logout(),
          icon: const Icon(Icons.logout),
        ),
      ]),
      body: SizedBox(
        child: Center(
          child: Column(
            children: [
              const Text('Programador de reuniones'),
              ElevatedButton(
                onPressed: () => context.pushNamed('login'),
                child: const Text("login"),
              ),
              ElevatedButton(
                onPressed: () => context.pushNamed('profile'),
                child: const Text("profile"),
              ),
              ElevatedButton(
                onPressed: () => context.pushNamed('dashboard'),
                child: const Text("dashboard"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
