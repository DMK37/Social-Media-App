import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/auth_repository.dart';
import 'package:social_media/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthLoadingState());

  Future<void> isAuthenticated() async {
    emit(AuthLoadingState());
    final user = await _authRepository.currentUser();
    if (user == null) {
      emit(UnauthenticatedState());
    } else {
      emit(AuthenticatedState(user: user));
    }
  }

  Future<void> signUp(String email, String password, String firstName,
      String lastName, String username) async {
    try {
      emit(AuthLoadingState());
      UserModel? user = await _authRepository.signUp(
          email, password, username, firstName, lastName);
      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(UnauthenticatedState());
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoadingState());
      await _authRepository.login(email, password);
      UserModel? currentUser = await _authRepository.currentUser();

      if (currentUser != null) {
        emit(AuthenticatedState(user: currentUser));
      } else {
        emit(AuthFailureState(errorMessage: 'login user failed'));
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());
    try {
      _authRepository.logout();
    } catch (e) {
      print('error');
      emit(AuthFailureState(errorMessage: e.toString()));
    }
    emit(UnauthenticatedState());
  }

  Future<void> continueProviderSignUp(
      String firstName, String lastName, String username) async {
    if (state is ProviderSignUpState) {
      UserModel? user = await _authRepository.continueProviderSignUp(
          (state as ProviderSignUpState).credential,
          firstName,
          lastName,
          username);
      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(
            AuthFailureState(errorMessage: "continue provider sign up failed"));
      }
    } else {
      emit(AuthFailureState(errorMessage: "continue provider sign up failed"));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoadingState());
      final credentials = await _authRepository.signInWithGoogle();
      if (credentials.$2 == null) {
        emit(ProviderSignUpState(credential: credentials.$1));
      } else {
        UserModel? currentUser = await _authRepository.currentUser();
        if (currentUser != null) {
          emit(AuthenticatedState(user: currentUser));
        } else {
          emit(AuthFailureState(errorMessage: 'login user failed'));
        }
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }

  //Future<void> continueProviderSignUp(String firstName, String secondName)

  Future<void> signInWithFacebook() async {
    try {
      emit(AuthLoadingState());
      final credentials = await _authRepository.signInWithFacebook();
      if (credentials.$2 == null) {
        emit(ProviderSignUpState(credential: credentials.$1));
      } else {
        UserModel? currentUser = await _authRepository.currentUser();
        if (currentUser != null) {
          emit(AuthenticatedState(user: currentUser));
        } else {
          emit(AuthFailureState(errorMessage: 'login user failed'));
        }
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }
}
