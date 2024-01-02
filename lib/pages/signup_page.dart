import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/views/provider_signup_view.dart';
import 'package:social_media/views/signup_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          context.go('/');
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          switch (state) {
            case AuthLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProviderSignUpState():
              return const ProviderSignUpView();
            case UnauthenticatedState():
              return const SignUpView();
          }

          return const SizedBox.shrink();
        },
      ), // replace with your widget
    );
  }
}
