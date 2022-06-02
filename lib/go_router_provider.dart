import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/views/dashboard_view.dart';
import 'package:programador_reuniones_flutter/views/group_detail.dart';
import 'package:programador_reuniones_flutter/views/login_view.dart';
import 'package:programador_reuniones_flutter/views/profile_view.dart';

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
          name: 'dashboard',
          pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
            key: state.pageKey,
            child: const DashboardView(),
          ),
        ),
	      GoRoute(
          path: '/perfil',
          name: 'perfil',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
            key: state.pageKey,
            child: const ProfileView(),
          ),
        ),
	      GoRoute(
          path: '/nuevo-grupo',
          name: 'nuevo-grupo',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
            key: state.pageKey,
            child: const NuevoGrupo(),
          ),
        GoRoute(
          path: '/detalleGrupo',
          name: 'detalleGrupo',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage<void>(
            key: state.pageKey,
            child: const GroupDetail(),
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
