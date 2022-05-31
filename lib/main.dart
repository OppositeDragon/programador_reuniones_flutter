import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/go_router_provider.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';

import 'firebase_options.dart';

void main() async {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    await FacebookAuth.i.webInitialize(appId: "602784674794577", cookie: true, xfbml: true, version: "v13.0");
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.read(routerProvider).routeInformationParser,
      routerDelegate: ref.read(routerProvider).routerDelegate,
      title: 'Programador de reuniones',
      theme: ref.watch(themeProvider).themeData,
    );
  }
	
}
