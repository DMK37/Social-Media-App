import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/scaffold_with_bottom_bar.dart';
import 'package:social_media/pages/create_page.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/profile_page.dart';
import 'package:social_media/pages/search_page.dart';
import 'package:social_media/pages/signup_page.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // the UI shell
            return ScaffoldWithBottomBar(
                navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
                navigatorKey:
                    GlobalKey<NavigatorState>(debugLabel: 'shellHome'),
                routes: [
                  GoRoute(
                    path: '/',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: HomePage());
                    },
                    redirect: (BuildContext context, GoRouterState state) {
                      if (context.read<AuthCubit>().state
                          is AuthenticatedState) {
                        return '/';
                      } else {
                        return '/login';
                      }
                    },
                  ),
                ]),
                StatefulShellBranch(
                navigatorKey:
                    GlobalKey<NavigatorState>(debugLabel: 'shellSearch'),
                routes: [
                  GoRoute(
                    path: '/search',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: SearchPage());
                    },
                    redirect: (BuildContext context, GoRouterState state) {
                      if (context.read<AuthCubit>().state
                          is AuthenticatedState) {
                        return '/search';
                      } else {
                        return '/login';
                      }
                    },
                  ),
                ]),
                StatefulShellBranch(
                navigatorKey:
                    GlobalKey<NavigatorState>(debugLabel: 'shellCreate'),
                routes: [
                  GoRoute(
                    path: '/create',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: CreatePage());
                    },
                    redirect: (BuildContext context, GoRouterState state) {
                      if (context.read<AuthCubit>().state
                          is AuthenticatedState) {
                        return '/create';
                      } else {
                        return '/login';
                      }
                    },
                  ),
                ]),
            StatefulShellBranch(
                navigatorKey:
                    GlobalKey<NavigatorState>(debugLabel: 'shellProfile'),
                routes: [
                  GoRoute(
                    path: '/profile',
                    pageBuilder: (context, state) {
                      return const MaterialPage(child: ProfilePage());
                    },
                    redirect: (BuildContext context, GoRouterState state) {
                      if (context.read<AuthCubit>().state
                          is AuthenticatedState) {
                        return '/profile';
                      } else {
                        return '/login';
                      }
                    },
                  ),
                ])
          ]),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
        redirect: (BuildContext context, GoRouterState state) {
          if (context.read<AuthCubit>().state is AuthenticatedState) {
            return '/';
          }
        },
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
        redirect: (BuildContext context, GoRouterState state) {
          if (context.read<AuthCubit>().state is AuthenticatedState) {
            return '/';
          }
        },
      ),
    ],
  );
}

