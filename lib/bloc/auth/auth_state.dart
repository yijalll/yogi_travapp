part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User data;

  const AuthSuccess({
    required this.data,
  });
}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({
    required this.message,
  });
}
