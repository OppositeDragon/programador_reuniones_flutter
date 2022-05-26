import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';
import 'package:programador_reuniones_flutter/views/dashboard_view.dart';
import 'package:programador_reuniones_flutter/views/login_view.dart';
import 'package:programador_reuniones_flutter/views/principal.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FacebookAuth.i.webInitialize(appId: "602784674794577", cookie: true, xfbml: true, version: "v13.0");
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      // initialLocation: '/login',
      routes: [
       
        GoRoute(
          path: '/',
          name: 'dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const Dashboard(),
          ),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const LoginView(),
          ),
        ),
      ],
      refreshListenable: ref.watch(loginProvider),
      redirect: (GoRouterState state) {
        print('currentUser => ${FirebaseAuth.instance.currentUser}');
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        final loggingIn = state.subloc == '/login';
        if (!loggedIn) return loggingIn ? null : '/login';
        // if the user is logged in but still on the login page, send them to
        // the home page
        if (loggingIn) return '/';

        // no need to redirect at all
        return null;
      },
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
