import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/views/principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programador de reuniones',
      theme: ref.watch(themeProvider).themeData,
      home: const Principal(),
    );
  }
}
