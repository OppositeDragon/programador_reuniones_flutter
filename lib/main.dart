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
import 'package:programador_reuniones_flutter/views/profile_view.dart';
import 'firebase_options.dart';
import 'package:programador_reuniones_flutter/views/principal.dart';

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
final routerProvider = Provider<GoRouter>((ref) {
	return  GoRouter(
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
          name: 'principal',
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
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const ProfileView(),
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
    
});
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
