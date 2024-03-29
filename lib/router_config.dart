import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/scaffold_with_bottom_bar.dart';
import 'package:social_media/pages/comments_page.dart';
import 'package:social_media/pages/create_page.dart';
import 'package:social_media/pages/edit_profile_page.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/post_page.dart';
import 'package:social_media/pages/profile_page.dart';
import 'package:social_media/pages/search_page.dart';
import 'package:social_media/pages/signup_page.dart';
import 'package:social_media/pages/user_page.dart';

class AppRouter {
  final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // the UI shell
            return ScaffoldWithBottomBar(navigationShell: navigationShell);
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
                  ),
                ])
          ]),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
      ),
      GoRoute(
          path: '/post/:postId',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: PostPage(postId: state.pathParameters['postId']!));
          },
          routes: [
            GoRoute(
              path: 'comments',
              pageBuilder: (context, state) {
                return MaterialPage(
                    child:
                        CommentsPage(postId: state.pathParameters['postId']!));
              },
            ),
          ]),
      GoRoute(
          path: "/user/:username",
          pageBuilder: (context, state) {
            return MaterialPage(
                child: UserPage(username: state.pathParameters['username']!));
          },
          redirect: (BuildContext context, GoRouterState state) {
            final authState = context.read<AuthCubit>().state;
            if (authState is AuthenticatedState &&
                authState.user.username == state.pathParameters['username']) {
              return '/profile';
            }
            return null;
          }),
          
      GoRoute(
        path: '/edit-profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: EditProfilePage());
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthenticatedState &&
          (state.uri.toString() == '/login' ||
              state.uri.toString() == '/signup')) {
        return '/';
      }
      if (authState is UnauthenticatedState &&
          state.uri.toString() == '/signup') {
        return '/signup';
      }
      if (authState is UnauthenticatedState) {
        return '/login';
      }
      return null;
    },
  );
}
