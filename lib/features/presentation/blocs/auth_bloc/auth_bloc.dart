import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';
import 'package:news_app/locator.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase _currentUserUseCase =
      GetCurrentUserUseCase(locator());
  final SignInWithEmailUseCase _signInWithEmailUseCase =
      SignInWithEmailUseCase(locator());
  final SignUpWithEmailUseCase _signUpWithEmailUseCase =
      SignUpWithEmailUseCase(locator());
  final SignOutUseCase _signOutUseCase = SignOutUseCase(locator());

  // User? user;

  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signUpWithEmailUseCase.execute(event.params);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (data) async {
        emit(Authenticated(data.user));
      },
    );
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signInWithEmailUseCase.execute(event.params);
    result.fold(
      (failure) => {
        emit(AuthFailure(failure.message)),
      },
      (data) => {
        emit(Authenticated(data.user)),
      },
    );
  }

  Future<void> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _currentUserUseCase.execute(NoParams());

    result.fold((failure) {}, (success) {
      if (success != null && success.email != null) {
        emit(Authenticated(success));
      }
    });
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signOutUseCase.execute(NoParams());
    result.fold(
        (failure) => {
              emit(AuthFailure(failure.message)),
            },
        (data) => {
              emit(AuthInitial()),
            });
  }
}
