import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/auth/cubit/auth_cubit.dart';
import 'package:social_media/auth/cubit/auth_state.dart';
import 'package:social_media/components/error_snack_bar.dart';
import 'package:social_media/views/provider_signup_view.dart';
import 'package:social_media/views/signup_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            context.go('/');
          }
          if(state is AuthFailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: ErrorSnackBar(
                errorMessage: state.errorMessage,
              ),
            ));
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
              case AuthFailureState(errorMessage: final errorMessage):
                return SignUpView(errorMessage: errorMessage,);
            }
      
            return const SizedBox.shrink();
          },
        ), // replace with your widget
      ),
    );
  }
}
