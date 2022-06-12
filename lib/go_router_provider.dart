import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/views/create_group_view.dart';
import 'package:programador_reuniones_flutter/views/dashboard_view.dart';
import 'package:programador_reuniones_flutter/views/group_detail_view.dart';
import 'package:programador_reuniones_flutter/views/login_view.dart';
import 'package:programador_reuniones_flutter/views/profile_view.dart';

final router = GoRouter(
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
        routes: [
          GoRoute(
            path: 'nuevoGrupo',
            name: 'nuevoGrupo',
            pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
              key: state.pageKey,
              child: const CreateGroupView(),
            ),
          ),
          GoRoute(
            path: 'detalleGrupo/:id',
            name: 'detalleGrupo',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final groupId = state.params['id'];
              return MaterialPage<void>(
                key: state.pageKey,
                child: GroupDetailView(groupId),
              );
            },
          ),
        ]),
    GoRoute(
      path: '/perfil',
      name: 'perfil',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
        key: state.pageKey,
        child: const ProfileView(),
      ),
    ),
  ],
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  redirect: (GoRouterState state) {
    final loggedIn = FirebaseAuth.instance.currentUser != null;
    final loggingIn = state.subloc == '/login';

    // bundle the location the user is coming from into a query parameter
    final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
    if (!loggedIn) return loggingIn ? null : '/login$fromp';

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) return state.queryParams['from'] ?? '/';
    // no need to redirect at all
    return null;
  },
);
