import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/views/principal.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programador de reuniones',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const Principal(),
    );
  }
}
