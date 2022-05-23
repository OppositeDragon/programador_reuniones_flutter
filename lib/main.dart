import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';
import 'package:programador_reuniones_flutter/views/dashboard_view.dart';
import 'package:programador_reuniones_flutter/views/login_view.dart';
import 'package:programador_reuniones_flutter/views/principal.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: '/',
          name: 'pricipal',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const Principal(),
          ),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const Dashboard(),
          ),
        )
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'Programador de reuniones',
      theme: ref.watch(themeProvider).themeData,
    );
  }
}
