import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/views/create_edit_group_view.dart';
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
      path: 'perfil',
      name: 'perfil',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage<void>(
        key: state.pageKey,
        child: const ProfileView(),
      ),
    ),
        GoRoute(
          path: 'grupo/nuevo',
          name: 'nuevo',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: const CreateEditGroupView('nuevo'),
            );
          },
        ),
        GoRoute(
          path: 'grupo/:gid',
          name: 'grupo',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: GroupDetailView(state.params['gid']!),
            );
          },
          routes: [
            GoRoute(
              path: 'editar',
              name: 'editar',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return MaterialPage<void>(
                  key: state.pageKey,
                  child: CreateEditGroupView(state.params['gid']!),
                );
              },
            ),
          ],
        ),
      ],
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
