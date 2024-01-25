import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/data/models/user_model.dart';
import 'package:social_media/data/repository/user_repository.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<UserModel> results;

  SearchLoaded({required this.results});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final UserRepository _userRepository = UserRepository();

  Future<void> search(String username) async {
    emit(SearchLoading());
    try {
      final results = await _userRepository.searchUser(username);
      emit(SearchLoaded(results: results));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> clear() async {
    emit(SearchInitial());
  }
}
